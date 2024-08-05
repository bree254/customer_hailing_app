import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AwaitDriverScreen extends StatefulWidget {
  const AwaitDriverScreen({super.key});

  @override
  State<AwaitDriverScreen> createState() => _AwaitDriverScreenState();
}

class _AwaitDriverScreenState extends State<AwaitDriverScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

  bool isSelected = false;

  final RideStatusController rideStatusController = Get.put(RideStatusController());

  Widget _buildStatusContent() {
    return Obx(() {
      switch (rideStatusController.currentStatus.value) {
        case RideStatus.searching:
          return _buildSearchingContent();
        case RideStatus.connecting:
          return _buildConnectingContent();
        case RideStatus.lookingForAnother:
          return _buildLookingForAnotherContent();
        default:
          return Container();
      }
    });
  }

  Widget _buildSearchingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Center(child: Padding(
           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60.0),
           child: LinearProgressIndicator(minHeight:4,borderRadius: BorderRadius.circular(20),),
         )),
        const SizedBox(height: 14),
        const Text("Searching for nearby drivers",  style: TextStyle(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 14),
        const Text(
          'Sit tight as we get the nearest available \ndriver for you!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: resendCodeTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: CustomElevatedButton(
            onPressed: () {
              // Handle cancel
              // Get.toNamed(AppRoutes.tripStatus);
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
              fontSize: 12,
              fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
        ),
      ],
    );
  }

  Widget _buildConnectingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60.0),
          child: LinearProgressIndicator(minHeight:4,borderRadius: BorderRadius.circular(20),),
        )),
        const SizedBox(height: 14),
        const Center(
          child: Text(
            "Connecting you to your driver",
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w600
          ),),
        ),
        const SizedBox(height: 14),
        const CircularProgressIndicator(),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: CustomElevatedButton(
            onPressed: () {
              // Handle cancel
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
        ),
      ],
    );
  }

  Widget _buildLookingForAnotherContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60.0),
          child: LinearProgressIndicator(minHeight:4,borderRadius: BorderRadius.circular(20),),
        )),
        const SizedBox(height: 14),
        const Text(
            "Looking for another driver",
          style: TextStyle(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal:0 ),
          child: Center(
              child: Text(
                  "Your previous driver did not confirm your request",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: resendCodeTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: CustomElevatedButton(
            onPressed: () {
              // Handle cancel
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _getUserLocation() async {
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
// Get the current location of the user
    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children :[
          _center == null
              ? Image.asset(
            'assets/images/map.png', // Path to your cached map image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
              : SizedBox(
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center!,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('user_location'),
                  position: _center!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                ),
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteTextColor,
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  // Handle menu button press
                },
                color: Colors.white,
                iconSize: 30.0,
                padding: const EdgeInsets.all(10),
                tooltip: 'Open Menu',
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.35,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: _buildStatusContent(),
                ),
              );
            },
          ),

        ]
      )

    );
  }
}
