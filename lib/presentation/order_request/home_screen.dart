import 'dart:async';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/global_variables/index.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currentPositionOfUser;

   CameraPosition googlePlexInitialPosition = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
  );

  Future<void> getCurrentLiveLocationOfUser() async {
    // Get the current position of the user
    Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);



    // Update the current position
    setState(() {
      currentPositionOfUser = positionOfUser;
    });

    // Convert the position to LatLng and move the camera
    LatLng positionOfUserInLatLng = LatLng(
      currentPositionOfUser!.latitude,
      currentPositionOfUser!.longitude,
    );
    CameraPosition cameraPosition = CameraPosition(
      target: positionOfUserInLatLng,
      zoom: 15,
    );
    controllerGoogleMap?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // Listen for position updates and move the camera accordingly
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    ).listen((Position position) {
      setState(() {
        currentPositionOfUser = position;
      });

      LatLng updatedPosition = LatLng(position.latitude, position.longitude);
      controllerGoogleMap?.animateCamera(CameraUpdate.newLatLng(updatedPosition));
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLiveLocationOfUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [


          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete(controllerGoogleMap);
            },
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            // Scrollable part of the bottom sheet
                            ListTile(
                              leading: Icon(Icons.directions_car),
                              title: Text('Economy'),
                              subtitle: Text('Ksh 460.0'),
                            ),
                            ListTile(
                              leading: Icon(Icons.motorcycle),
                              title: Text('Boda'),
                              subtitle: Text('Ksh 210.0'),
                            ),
                            ListTile(
                              leading: Icon(Icons.local_taxi),
                              title: Text('Taxi Comfort'),
                              subtitle: Text('Ksh 520.0'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Fixed part of the bottom sheet
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.money),
                                    SizedBox(width: 8),
                                    Text('Cash'),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.credit_card),
                                    SizedBox(width: 8),
                                    Text('Card'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          CustomElevatedButton(text: 'Select economy'),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: Text('Select economy'),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.purple,
                          //   ),
                          // ),
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
