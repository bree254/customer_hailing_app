import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_export.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  Rx<LatLng?> center = Rx<LatLng?>(null);
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString currentAddress = ''.obs;

  LatLng? _center;
  final Set<Polyline> polylines = <Polyline>{}.obs;
  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  // Initialize Google Map controller
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Get the current location of the user
  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request permission to get the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // Get the user's current position
    currentPosition.value = await Geolocator.getCurrentPosition();

    if (currentPosition.value != null) {
      center.value = LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude);
      await _convertToAddress(currentPosition.value!.latitude, currentPosition.value!.longitude);
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

  // Update the polyline on the map
  void updatePolyline(String destinationAddress) async {
    LatLng? destinationCoords = await getCoordinatesFromAddress(destinationAddress);
    if (destinationCoords != null) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          visible: true,
          color: primaryColor, // Change the color as needed
          width: 5,
          points: [_center!, destinationCoords],
        ),
      );
      update(); // Update the view
    }
    }

}