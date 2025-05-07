import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/widgets/await_driver_bottomsheet_widget.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/map_controller.dart';
import 'map_screen.dart';
class AwaitDriverScreen extends StatefulWidget {
  const AwaitDriverScreen({super.key});

  @override
  State<AwaitDriverScreen> createState() => _AwaitDriverScreenState();
}

class _AwaitDriverScreenState extends State<AwaitDriverScreen> {
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerWidget(),
      body:Stack(
        children :[
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
           Positioned(
            top: 40,
            left: 20,
           child: Builder(
             builder: (context) {
               return MenuIconWidget(
                 onPressed: () {
                   Scaffold.of(context).openDrawer();
                 },);
             }
           ),
          ),
          AwaitDriverBottomsheetWidget(),

        ]
      )

    );
  }
}
