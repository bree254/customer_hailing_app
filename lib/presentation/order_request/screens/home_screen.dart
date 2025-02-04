import 'package:customer_hailing/widgets/destination_bottomsheet_widget.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../controller/map_controller.dart';

class HomeScreen extends StatelessWidget {
  final MapController _mapController = Get.put(MapController());

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  DrawerWidget(),
      body: Stack(
        children: [
          Obx(() => _mapController.center.value == null
              ? Image.asset(
            'assets/images/map.png', // Path to your cached map image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
              : SizedBox(
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: _mapController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _mapController.center.value!,
                zoom: 17.5,
              ),
              //markers: _mapController.markers,
              markers: Set<Marker>.from(_mapController.markers),
            ),
          )),
          Obx(() => DestinationBottomSheet(currentAddress: _mapController.currentAddress.value)),
          Positioned(
            top: 40,
            left: 20,
            child: Builder(builder: (context) {
              return MenuIconWidget(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
          )
        ],
      ),
    );
  }
}


