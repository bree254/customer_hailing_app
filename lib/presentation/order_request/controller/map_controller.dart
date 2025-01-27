import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as polyline;
import '../../../core/app_export.dart';
import 'package:google_directions_api/google_directions_api.dart' as directions;

import '../../../data/models/ride_requests/driver_locations_response.dart';
import '../../../data/services/web_sockets/web_socket_service.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  Rx<LatLng?> center = Rx<LatLng?>(null);
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString currentAddress = ''.obs;

  BitmapDescriptor ? customMarker,destinationMarker;
  var markers = <Marker>{}.obs;

  // Initialize the Directions API
  final directions.DirectionsService directionsService = directions.DirectionsService();


  LatLng? _center;
  final Set<Polyline> polylines = <Polyline>{}.obs;

  late WebSocketService webSocketService;

  @override
  void onInit() {
    super.onInit();
     checkAndRequestPermission();
    directions.DirectionsService.init(dotenv.env['GOOGLE_API_KEY']!);
    getUserLocation();
    updatePolyline;
    _loadCustomMarker();
    _updateMarkers([]);

    webSocketService = WebSocketService(
        onDriverLocationsReceived: (driverLocations) {
          _updateMarkers(driverLocations);
        });
    webSocketService.connect();

  }

  Future<void> _updateMarkers(List<DriverLocationsResponse> driverLocations) async {

      markers.clear();

      // Add user location marker (if it's set)
      if (center.value != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: center.value!,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      }

      for (var driver in driverLocations) {
        // Only extract the necessary data (driverId, latitude, longitude)
        double latitude = driver.latitude!;
        double longitude = driver.longitude!;
        String driverId = driver.driverId!;

        // Use your custom car marker image from assets
        BitmapDescriptor carMarker = await BitmapDescriptor.asset(
          ImageConfiguration(size: Size(100, 100)), // Optional: Specify the size
          'assets/images/mazda.png',
        );


        markers.add(
          Marker(
            markerId: MarkerId(driverId),
            position: LatLng(latitude, longitude),
            //icon: carMarker,
            icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
            infoWindow: InfoWindow(title: "Driver $driverId"),
          ),
        );
      }
      update();
  }

  Future<void> _loadCustomMarker() async {
    customMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/driver_marker.png', // Path to your custom marker image
    );
    destinationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/destination_marker.png', // Path to your custom marker image
    );
  }


  // Initialize Google Map controller
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
// Check and request location permission
  Future<void> checkAndRequestPermission() async {
    var status = await Permission.location.status;

    // If permission is denied, request permission
    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isGranted) {
        // Permission granted, get user location
        await getUserLocation();
      } else {
        print('Location permission denied.');
      }
    } else if (status.isGranted) {
      // Permission already granted, get user location
      await getUserLocation();
    } else if (status.isPermanentlyDenied) {
      // Handle case where permission is permanently denied
      print('Location permission is permanently denied. Open settings to enable.');
      openAppSettings(); // Optionally prompt the user to open settings
    }
  }
  // Get the current location of the user
  Future<void> getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          return;
        }
      }

      currentPosition.value = await Geolocator.getCurrentPosition();

      if (currentPosition.value != null) {
        _center = LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude);
        center.value = _center;
        await _convertToAddress(currentPosition.value!.latitude, currentPosition.value!.longitude);
        addCenterMarker(_center!);
      }
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  // Convert coordinates to a human-readable address
  Future<void> _convertToAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      currentAddress.value = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }
  }

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      }
    } catch (e) {
      print('Error getting coordinates from address: $e');
    }
    return null;
  }

  void addCenterMarker(LatLng position) {
    markers.add(
      Marker(
        markerId: const MarkerId('center'),
        position: position,
        icon: customMarker!,
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );
    update();
  }

  void addDestinationMarker(LatLng position) {
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: position,
        icon: destinationMarker!,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );
    update();
  }

  // Update the polyline on the map
  void updatePolyline(String destinationAddress) async {
    LatLng? destinationCoords = await getCoordinatesFromAddress(destinationAddress);

    if (destinationCoords != null && _center != null) {
      polyline.PolylinePoints polylinePoints = polyline.PolylinePoints();
      polyline.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey:dotenv.env['GOOGLE_API_KEY']!,
        request: polyline.PolylineRequest(
          mode: polyline.TravelMode.driving,
          origin: polyline.PointLatLng(_center!.latitude, _center!.longitude),
          destination: polyline.PointLatLng(destinationCoords.latitude, destinationCoords.longitude),
        ),
      );
      print(result);

      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            visible: true,
            color: primaryColor,
            width: 5,
            points: polylineCoordinates,
          ),
        );
        addDestinationMarker(destinationCoords);
        update(); // Update the view
      }
    }
  }

}