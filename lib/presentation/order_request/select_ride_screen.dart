import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/data.dart';

class SelectRideScreen extends StatefulWidget {
  const SelectRideScreen({super.key});

  @override
  State<SelectRideScreen> createState() => _SelectRideScreenState();
}

class _SelectRideScreenState extends State<SelectRideScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

  bool isSelected = false;

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
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 5,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 50,
                      // clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(600),
                      ),
                      child: const Divider(
                        height: 15,
                        thickness: 4,
                        // color: colorwhite,
                        color: lightGrey,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: MyData.requests.length,
                          itemBuilder: (context, index) {
                            var request = MyData.requests[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              margin: const EdgeInsets.fromLTRB( 16, 0,16,8),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0x3FFAFAFA),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.05000000074505806),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: ListTile(
                                selectedColor: selectRideColor,
                                selectedTileColor: selectRideColor,
                                onTap: () {
                                  Get.toNamed(AppRoutes.selectRide);
                                },
                                leading:
                                    Image(image: AssetImage(request.imageUrl)),
                                title: Text(
                                  request.ridetype,
                                  style: const TextStyle(
                                    color: searchtextGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  request.timeEstimate,
                                  style: const TextStyle(
                                    color: searchtextGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(request.discountedPrice.toString()),
                                    Text(
                                      request.originalprice.toString(),
                                      style: const TextStyle(
                                          // decoration: TextDecoration.underline
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    // Fixed part of the bottom sheet
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap:(){

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? selectRideColor : whiteTextColor,
                                    // border: BorderSide(width: 1,color: disabledButtonGrey)
                                  ),
                                  child: const Row(
                                    children: [
                                      Image(
                                          width: 13,
                                          height: 13,
                                          image: AssetImage(
                                              'assets/images/cash.png')),
                                      SizedBox(width: 8),
                                      Text('Cash'),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap:(){

                                },
                                child: Container(
                                  child: const Row(
                                    children: [
                                      Image(
                                          width: 13,
                                          height: 13,
                                          image: AssetImage(
                                              'assets/images/card.png')),
                                      SizedBox(width: 8),
                                      Text('Card'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomElevatedButton(text: 'Select economy'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
