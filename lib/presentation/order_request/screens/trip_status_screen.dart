import 'dart:async';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/controller/map_controller.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:customer_hailing/widgets/trip_status_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/ride_requests/locations_update_response.dart';
import 'map_screen.dart';

class TripStatusScreen extends StatefulWidget {
  const TripStatusScreen({super.key});

  @override
  State<TripStatusScreen> createState() => _TripStatusScreenState();
}
class _TripStatusScreenState extends State<TripStatusScreen> {
  final MapController mapController = Get.put(MapController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startLocationUpdates();
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
    BitmapDescriptor carIcon = await mapController.getNetworkImageMarker(carIconUrl);

    // Update the marker
    mapController.markers.removeWhere((marker) => marker.markerId.value == 'driverLocation');
    mapController.markers.add(Marker(
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
    final tripStatus = mapController.rideServiceController.tripDetails.value.tripStatus;
    debugPrint('trip status in update map with location : $tripStatus');

    final pickupLocation = mapController.rideServiceController.tripDetails.value.tripDetails!.pickupLocation!;
    debugPrint('pickup location in update map with location : ${pickupLocation.address}');

    final destinationLocation = mapController.rideServiceController.tripDetails.value.tripDetails!.dropOffLocation!;
    debugPrint('destination location in update map with location : ${destinationLocation.address}');

    String driverAddress = await mapController.convertToAddress(newLocation.latitude, newLocation.longitude);
    debugPrint('driver address in update map with driver location : $driverAddress');

    // Update polylines based on trip status using switch-case
    switch (tripStatus) {
      case 'ACCEPTED':
      case 'DRIVER_ARRIVED':
        print('updating polylines for driver location: $driverAddress');
        print('updating polylines for driver location: $pickupLocation');
        print('Updating polyline: Driver at ${newLocation.latitude}, ${newLocation.longitude}');
        mapController.updateLatLngPolylines(pickupLocation.latitude!, pickupLocation.longitude!, newLocation.latitude, newLocation.longitude);
        break;
      case 'IN_PROGRESS':
        print('Updating polyline IN_PROGRESS : Driver at ${newLocation.latitude}, ${newLocation.longitude}');
        mapController.updateLatLngPolylines(newLocation.latitude, newLocation.longitude, destinationLocation.latitude!, destinationLocation.longitude!);
        break;
      case 'COMPLETED':
        mapController.stopLocationUpdates();
        break;
      default:
        mapController.stopLocationUpdates();
        break;
    }

    setState(() {}); // Update the view
  }

  void startLocationUpdates()  {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    mapController.positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) async {
      mapController.currentPosition.value = position;
      print('New position: ${position.latitude}, ${position.longitude}');

      LocationsUpdatesResponse response= await mapController.getLocationUpdates(mapController.rideServiceController.tripDetails.value.tripId.toString());
      updateMapWithLocation(LocationsUpdatesResponse(
        latitude: response.latitude,
        longitude: response.longitude,
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          MapScreen(),
          // Obx(() => mapController.center.value == null
          //     ? Image.asset(
          //   'assets/images/map.png',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // )
          //     : SizedBox(
          //   height: double.infinity,
          //   child: GoogleMap(
          //     onMapCreated: mapController.onMapCreated,
          //     initialCameraPosition: CameraPosition(
          //       target: mapController.center.value!,
          //       zoom: 16.0,
          //     ),
          //     markers: mapController.markers,
          //     polylines: mapController.polylines,
          //   ),
          // )),
          TripStatusBottomSheet(),
          Positioned(
            top: 40,
            left: 20,
            child: Builder(
              builder: (context) {
                return MenuIconWidget(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
