import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../controller/map_controller.dart';

class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  final bool showMarkers;
  final bool showPolylines;
  final Function(GoogleMapController)? onMapCreated;

  MapScreen({
    Key? key,
    this.showMarkers = true,
    this.showPolylines = true,
    this.onMapCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return mapController.center.value == null
          ? Image.asset(
        'assets/images/map.png', // Path to your cached map image
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      )
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
            child: GoogleMap(
                onMapCreated: (controller) {
                  mapController.onMapCreated(controller);
                  if (onMapCreated != null) {
                    onMapCreated!(controller);
                  }
                },
                initialCameraPosition: CameraPosition(
                  target: mapController.center.value!,
                  zoom: 15.0,
                ),
                markers: showMarkers
                    ? Set<Marker>.from(mapController.markers)
                    : {},
                polylines: showPolylines
                    ? Set<Polyline>.from(mapController.polylines)
                    : {},
              ),
          );
    });
  }
}