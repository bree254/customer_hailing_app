import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

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
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
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
        body: Stack(
      children: [
        _center == null
            ? const Center(child: CircularProgressIndicator())
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
        DestinationBottomSheet(),
      ],
    ));
  }
}

class DestinationBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final RideRequestController controller = Get.find<RideRequestController>();

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'where do you want to go',
                        labelStyle: TextStyle(
                          color: searchtextGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        fillColor: searchButtonGrey,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        prefixIcon: Icon(Icons.search, size: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: MyData.destinations.length,
                      itemBuilder: (context, index) {
                        var destination = MyData.destinations[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          elevation: 0,
                          color: searchButtonGrey,
                          // color: whiteTextColor,
                          child: ListTile(
                            onTap: () {
                              Get.toNamed(AppRoutes.selectRide);
                            },
                            leading: Icon(
                              Icons.history,
                              color: historyIcon,
                            ),
                            title: Text(
                              destination.address,
                              style: TextStyle(
                                color: searchtextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              destination.location,
                              style: TextStyle(
                                color: searchtextGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }))

              // Expanded(
              //   child: Obx(
              //         () => ListView.builder(
              //       controller: scrollController,
              //       itemCount: controller.destinations.length,
              //       itemBuilder: (context, index) {
              //         final destination = controller.destinations[index];
              //         return Card(
              //           child: ListTile(
              //             title: Text(destination.name),
              //             subtitle: Text(destination.address),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
