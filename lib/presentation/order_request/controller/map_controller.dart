import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

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
    // checkAndRequestPermission();
    getUserLocation();
  }

  // Initialize Google Map controller
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
// // Check and request location permission
//   Future<void> checkAndRequestPermission() async {
//     var status = await Permission.location.status;
//
//     // If permission is denied, request permission
//     if (status.isDenied) {
//       status = await Permission.location.request();
//       if (status.isGranted) {
//         // Permission granted, get user location
//         await getUserLocation();
//       } else {
//         print('Location permission denied.');
//       }
//     } else if (status.isGranted) {
//       // Permission already granted, get user location
//       await getUserLocation();
//     } else if (status.isPermanentlyDenied) {
//       // Handle case where permission is permanently denied
//       print('Location permission is permanently denied. Open settings to enable.');
//       openAppSettings(); // Optionally prompt the user to open settings
//     }
//   }
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