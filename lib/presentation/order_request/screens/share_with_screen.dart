import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/map_controller.dart';
class ShareWithScreen extends StatefulWidget {
  const ShareWithScreen({super.key});

  @override
  State<ShareWithScreen> createState() => _ShareWithScreenState();
}

class _ShareWithScreenState extends State<ShareWithScreen> {
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
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
                markers: {
                  Marker(
                    markerId: const MarkerId('user_location'),
                    position: mapController.center.value!,
                    infoWindow: const InfoWindow(title: 'Your Location'),
                  ),
                },
                polylines: mapController.polylines,
              ),
            )),
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.3,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                        child: Text(
                          'Share with',
                          style:AppTextStyles.bodyHeading,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                          child: ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: MyData.profiles.length,
                              itemBuilder: (BuildContext context,int index){
                                var profile = MyData.profiles[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        Get.toNamed(AppRoutes.chats,arguments: profile.name);

                                },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 0.v,horizontal: 14.h),
                                        width: 52.h,
                                        height: 52.v,
                                        decoration:  BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(profile.imageUrl),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                     Text(
                                      profile.name,
                                       style:AppTextStyles.bodySmall.copyWith(
                                         color: darkerGrey,
                                       ),
                                    )

                                  ],
                                );

                      }))
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
        )
    );
  }
}
