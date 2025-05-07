import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/map_controller.dart';
import 'map_screen.dart';

class ShareTripDetailsScreen extends StatefulWidget {
  const ShareTripDetailsScreen({super.key});

  @override
  State<ShareTripDetailsScreen> createState() => _ShareTripDetailsScreenState();
}

class _ShareTripDetailsScreenState extends State<ShareTripDetailsScreen> {
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerWidget(),
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
        DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.2,
          maxChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(600),
                    ),
                    child: const Divider(
                      height: 10,
                      thickness: 4,
                      color: lightGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Safety',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    leading: Image.asset(
                        height: 24, width: 24, 'assets/images/share.png'),
                    title:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Share your ride details',
                            style: AppTextStyles.listTileTitle.copyWith(
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(
                            'Let other know where you are',
                            style: AppTextStyles.listTileSubtitle.copyWith(
                              color:darkerGrey,
                            )
                        )
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap:(){
                        Get.toNamed(AppRoutes.shareWith);
                      },
                        child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14,
                    )),
                  ),
                  ListTile(
                    onTap:(){
                      Get.toNamed(AppRoutes.emergency);

                    },
                    leading: Image.asset(
                        height: 24, width: 24, 'assets/images/bell.png'),
                    title:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Assistance',
                            style: AppTextStyles.listTileTitle.copyWith(
                              fontWeight: FontWeight.w600,
                              color:redColor
                            )
                        ),
                        Text(
                          'Call for emergency services',
                            style: AppTextStyles.listTileSubtitle.copyWith(
                              color:darkerGrey,
                            )
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
         Positioned(
          top: 40,
          left: 20,
          child: Builder(
            builder: (context) {
              return MenuIconWidget(onPressed: () {  Scaffold.of(context).openDrawer(); },);
            }
          ),
        )
      ],
    ));
  }
}
