import 'dart:async';
import 'dart:typed_data';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as polyline;
import '../../../core/app_export.dart';
import 'package:google_directions_api/google_directions_api.dart' as directions;
import 'package:http/http.dart' as http;
import '../../../core/constants/constants.dart';
import '../../../data/api/endpoints.dart';
import '../../../data/models/ride_requests/driver_locations_response.dart';
import '../../../data/models/ride_requests/locations_update_response.dart';
import '../../../data/repos/ride_service_repository.dart';
import '../../../data/services/web_sockets/web_socket_service.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  Rx<LatLng?> center = Rx<LatLng?>(null);
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString currentAddress = ''.obs;

  BitmapDescriptor ? customMarker,destinationMarker;
  var markers = <Marker>{}.obs;

  LatLng? _center;
 // final Set<Polyline> polylines = <Polyline>{}.obs;
  final RxSet<Polyline> polylines = <Polyline>{}.obs;

  late WebSocketService webSocketService;

  String ? accessToken;
  RxList<DriverLocationsResponse> drivers = <DriverLocationsResponse>[].obs;
  final RideServiceRepository rideServiceRepository = RideServiceRepository();

  final RideServiceController rideServiceController = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));

  final directions.DirectionsService directionsService =
  directions.DirectionsService();
  var directionsSteps = [].obs;


  final StreamController<List<DriverLocationsResponse>> _driverLocationsController = StreamController<List<DriverLocationsResponse>>.broadcast();
  Stream<List<DriverLocationsResponse>> get driverLocationsStream => _driverLocationsController.stream;
  Timer? _locationUpdateTimer;

  Timer? _driverLocationsTimer;

  var locationUpdates = LocationsUpdatesResponse().obs;

  StreamSubscription<Position>? positionStreamSubscription;

  @override
  Future<void> onInit() async {
    super.onInit();
    accessToken = await PrefUtils().retrieveToken('access_token');

     checkAndRequestPermission();
    directions.DirectionsService.init(dotenv.env['GOOGLE_API_KEY']!);

    // webSocketService = WebSocketService(
    //     onDriverLocationsReceived: (List<DriverLocationsResponse> driverLocations) {
    //       updateMarkers(driverLocations);
    //     });
    // webSocketService.connect();

    getUserLocation();
    updatePolyline;

    _loadCustomMarker();
    //getDriverLocations();

    // Start the periodic update
    _startDriverLocations();

  }


  void _startDriverLocations() {
    _driverLocationsTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await _fetchDriverLocations();
    });
  }

  Future<void> _fetchDriverLocations() async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // Replace with your token logic
      };

      print('get driver locations Request URL: ${Endpoints.driverLocations}');
      print('get driver locations Headers: $headers');

      List<DriverLocationsResponse> response = await rideServiceRepository.getDriverLocations(headers: headers);

      drivers.assignAll(response);
      print('driver locations fetched successfully: in map controller  ${response.map((e) => e.toJson()).toList()}');

      // Add driver markers
      await updateDriverMarkers();

      // Add the fetched driver locations to the stream
      _driverLocationsController.add(response);
    } catch (e) {
      print('Error fetching drivers: $e');
    }
  }

  Future<BitmapDescriptor> getNetworkImageMarker(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;
      return BitmapDescriptor.fromBytes(bytes);
    } else {
      // Fallback to a default icon if the network image fails to load
      return BitmapDescriptor.defaultMarker;
    }
  }


  Future<void> updateDriverMarkers() async {
    Set<Marker> newMarkers = {};

    const double offset = 0.0020; // Offset value to slightly move markers

    // Add driver markers
    for (var i = 0; i < drivers.length; i++) {
      var driver = drivers[i];
      if (driver.latitude != null && driver.longitude != null) {
        // Apply offset to avoid stacking
        double offsetLatitude = driver.latitude! + (i * offset);
        double offsetLongitude = driver.longitude! + (i * offset);

        // Construct the full URL for the car icon
        String carIconUrl = imageBaseUrl + (driver.carIcon ?? 'assets/images/mid_car_marker.png');
        print(' car icon url : $carIconUrl');

        // Load the car icon from the URL
        BitmapDescriptor carIcon = await getNetworkImageMarker(carIconUrl);

        newMarkers.add(
          Marker(
            markerId: MarkerId(driver.driverId ?? "unknown"),
            position: LatLng(offsetLatitude, offsetLongitude),
            icon: carIcon,
            infoWindow: InfoWindow(
              title: driver.vehicleDetails?.makeAndModel ?? "Unknown Vehicle",
              snippet: "Rating: ${driver.rating}",
            ),
          ),
        );

        print("Adding marker for driver ${driver.driverId} at (${offsetLatitude}, ${offsetLongitude})");
        print("Adding car marker for driver ${driver.carIcon} at (${offsetLatitude}, ${offsetLongitude})");
      }
    }

    // Ensure the center marker is not removed
    if (center.value != null) {
      newMarkers.add(
        Marker(
          markerId: const MarkerId("center"),
          position: center.value!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: const InfoWindow(title: "You are here"),
        ),
      );

      print("Adding center marker at (${center.value!.latitude}, ${center.value!.longitude})");
    }

    // Assign updated markers
    markers.assignAll(newMarkers);
    markers.refresh(); // Force UI update

    print("Updated markers count: ${markers.length}");
  }


  Future<LocationsUpdatesResponse> getLocationUpdates(String tripId) async {
   // final RideServiceController rideServiceController = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));
    final status = rideServiceController.tripDetails.value.tripStatus;
    debugPrint('trip status in get location updates : $status');
    if (status == 'COMPLETED') {
      _locationUpdateTimer?.cancel(); // Stop the timer when the trip is completed
      throw Exception('Trip is completed');;
    }

    // Only fetch updates if the status is between ACCEPTED and IN_PROGRESS
    if (status != 'ACCEPTED' && status != 'DRIVER_ARRIVED' && status != 'IN_PROGRESS') {
      throw Exception('Invalid trip status');
    }
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Get location updates with tripId: $tripId');
      print('Get location updates Request URL: ${Endpoints.locationUpdates}$tripId');
      print('Get location updates Headers: $headers');

      LocationsUpdatesResponse response = await rideServiceRepository.locationUpdates(
        headers: headers,
        tripId: tripId,
      );

      // Update the map with new location data

      //updateMapWithLocation(response);
      print('location updates fetched successfully: ${response.toJson()}');
    return  locationUpdates.value = response;

    } catch (e) {
      print('Error fetching location updates : $e');
      throw Exception('Error fetching location updates');
    }
  }

  Future<void> updateMapWithLocation(LocationsUpdatesResponse response) async {
    // Assuming response contains the new location data
    final newLocation = LatLng(response.latitude ?? 0.0, response.longitude ?? 0.0);

    debugPrint(newLocation.toString());
    debugPrint('new location for location updates : $newLocation');

    // Construct the full URL for the car icon
    String carIconUrl = imageBaseUrl + (response.carIcon ?? 'assets/images/mid_car_marker.png');
    print(' car icon url for updates  : $carIconUrl');

    // Load the car icon from the URL
    BitmapDescriptor carIcon = await getNetworkImageMarker(carIconUrl);

    // Update the marker
    markers.removeWhere((marker) => marker.markerId.value == 'driverLocation');
    markers.add(Marker(
      markerId: MarkerId('driverLocation'),
      position: newLocation,
      infoWindow: InfoWindow(
        title: response.vehicleDetails?.numberPlate ?? 'Unknown Vehicle',
        snippet: 'Rating: ${response.rating}',
      ),
      icon: carIcon,
    ));

    print("Adding marker for driver location updates  ${response.driverId} at (${newLocation.latitude}, ${newLocation.longitude})");
    print("Adding car marker for driver  location updates ${response.carIcon} at (${newLocation.latitude}, ${newLocation.longitude})");

    // Get the trip status and locations
    final tripStatus = rideServiceController.tripDetails.value.tripStatus;
    debugPrint('trip status in update map with location : $tripStatus');

    final pickupLocation = rideServiceController.tripDetails.value.tripDetails!.pickupLocation!;
    debugPrint('pickup location in update map with location : ${pickupLocation.address}');

    final destinationLocation = rideServiceController.tripDetails.value.tripDetails!.dropOffLocation!;
    debugPrint('destination location in update map with location : ${destinationLocation.address}');

    String driverAddress = await convertToAddress(newLocation.latitude, newLocation.longitude);
    debugPrint('driver address in update map with driver location : $driverAddress');

    // Update polylines based on trip status using switch-case
    switch (tripStatus) {
      case 'ACCEPTED':
        print('locations with statuses: $tripStatus');
        print('updating polylines for driver location: $driverAddress');
        print('updating polylines for driver location: $pickupLocation');
        print('Updating polyline: Driver at ${newLocation.latitude}, ${newLocation.longitude}');
        updateLatLngPolylines(pickupLocation.latitude!, pickupLocation.longitude!, newLocation.latitude, newLocation.longitude);
      case 'DRIVER_ARRIVED':
        print('updating polylines for driver location: $driverAddress');
        print('updating polylines for driver location: $pickupLocation');
        print('Updating polyline: Driver at ${newLocation.latitude}, ${newLocation.longitude}');
        updateLatLngPolylines(pickupLocation.latitude!, pickupLocation.longitude!, newLocation.latitude, newLocation.longitude);
        break;
      case 'IN_PROGRESS':
        updateLatLngPolylines(newLocation.latitude, newLocation.longitude, destinationLocation.latitude!, destinationLocation.longitude!);
        break;
      case 'COMPLETED':
        _locationUpdateTimer?.cancel();
        break;
      default:
        stopLocationUpdates();
        break;
    }

    update(); // Update the view
  }

  void stopLocationUpdates() {
    _locationUpdateTimer?.cancel();
  }

 // Destination & Pickup Location Markers
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
   // update() ;
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
      //addCenterMarker(_center!);
      await _convertToAddress(currentPosition.value!.latitude, currentPosition.value!.longitude);
      update();
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

  Future<String> convertToAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }
    return "Unknown location";
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
        icon: destinationMarker!,
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
        icon: customMarker!,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );
    update();
  }

  // Update the polyline on the map when the current location used is the one one from the geolocator
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

        // Add destination marker
        markers.add(
          Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(destinationCoords.latitude, destinationCoords.longitude),
            icon: customMarker!,
          ),
        );
        //addDestinationMarker(destinationCoords);

        // Start the animation
        //startPolylineAnimation(polylineCoordinates);
      }
    }
  }
//update polyline method using coordinates
  void updateLatLngPolylines(double originLat, double originLng, double destLat, double destLng) async {
    LatLng originCoords = LatLng(originLat, originLng);
    LatLng destinationCoords = LatLng(destLat, destLng);

    polyline.PolylinePoints polylinePoints = polyline.PolylinePoints();
    polyline.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dotenv.env['GOOGLE_API_KEY']!,
      request: polyline.PolylineRequest(
        mode: polyline.TravelMode.driving,
        origin: polyline.PointLatLng(originCoords.latitude, originCoords.longitude),
        destination: polyline.PointLatLng(destinationCoords.latitude, destinationCoords.longitude),
      ),
    );

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

      // Add destination marker
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(destinationCoords.latitude, destinationCoords.longitude),
          icon: customMarker!,
        ),
      );
      //addDestinationMarker(destinationCoords);
      // Force refresh the observable set
      polylines.refresh();
      update(); // Ensure this is called to notify GetX of the state change
      print('Polylines ltling  updated: ${polylines.length}');
    }
  }

  //update polyline method when the destination and origin address keep changing

  void updatePolylines(String originAddress, String destinationAddress) async {
    LatLng? originCoords = await getCoordinatesFromAddress(originAddress);
    debugPrint('Origin coordinates: $originCoords');
    LatLng? destinationCoords = await getCoordinatesFromAddress(destinationAddress);
    debugPrint('Destination coordinates: $destinationCoords');

    if (originCoords != null && destinationCoords != null) {
      polyline.PolylinePoints polylinePoints = polyline.PolylinePoints();
      polyline.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: dotenv.env['GOOGLE_API_KEY']!,
        request: polyline.PolylineRequest(
          mode: polyline.TravelMode.driving,
          origin: polyline.PointLatLng(originCoords.latitude, originCoords.longitude),
          destination: polyline.PointLatLng(destinationCoords.latitude, destinationCoords.longitude),
        ),
      );
      print(' polyline result: $result');
      print('Polyline result: ${result.points.map((point) => '(${point.latitude}, ${point.longitude})').toList()}');

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
        // Add destination marker
        markers.add(
          Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(destinationCoords.latitude, destinationCoords.longitude),
            icon: customMarker!,
          ),
        );
        //addDestinationMarker(destinationCoords);
        update();
      }
    }
  }

}


