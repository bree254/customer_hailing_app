import 'dart:async';

import 'package:customer_hailing/global_variables/index.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> googleMapController =Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController){

              googleMapController.complete(mapController);
            },
          )
        ],
      ),
    );
  }
}
