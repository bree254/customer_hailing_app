import 'dart:async';

import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/repos/ride_service_repository.dart';
import 'package:customer_hailing/presentation/order_request/controller/map_controller.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:customer_hailing/widgets/trip_status_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/trip_status_controller.dart';

class TripStatusScreen extends StatefulWidget {
  const TripStatusScreen({super.key});

  @override
  State<TripStatusScreen> createState() => _TripStatusScreenState();
}
class _TripStatusScreenState extends State<TripStatusScreen> {
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          Obx(() => mapController.center.value == null
              ? Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
              : SizedBox(
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: mapController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapController.center.value!,
                zoom: 16.0,
              ),
              markers: mapController.markers,
              polylines: mapController.polylines,
            ),
          )),
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
