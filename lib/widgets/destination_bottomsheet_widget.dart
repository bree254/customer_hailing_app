import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/controller/home_controller.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

import '../data/repos/ride_service_repository.dart';
class DestinationBottomSheet extends StatelessWidget {
  final String? currentAddress;

  const DestinationBottomSheet({super.key, this.currentAddress});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final RideServiceController controller = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));
    List<String> pastDestinations = PrefUtils().getPastDestinations();

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(top:8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                // clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(600),
                ),
                child: const Divider(
                  height: 20,
                  thickness: 4,
                  // color: colorwhite,
                  color: lightGrey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.search, arguments: currentAddress);
                },

                child: Container(
                  margin:
                  const EdgeInsets.fromLTRB( 10, 8,10,0),
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'where do you want to go',
                        labelStyle: AppTextStyles.bodySmallBold.copyWith(
                        color: searchtextGrey,
                      ),
                        fillColor: searchButtonGrey,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        prefixIcon: const Icon(Icons.search, size: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Obx(() => homeController.pastDestinations.isEmpty
                      ? const Center(
                    child: Text('No past destinations'),
                  )

                      : ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: homeController.pastDestinations.length,
                        itemBuilder: (context, index) {
                          var pastDestination = homeController.pastDestinations[index];
                          return Container(
                            margin: const EdgeInsets.fromLTRB( 16,0,16 ,8),
                            decoration: ShapeDecoration(
                              color: const Color(0x7FFAFAFA),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black.withOpacity(0.02500000037252903),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: ListTile(
                              onTap: () async {
                                await controller.uploadCustomerLocationWithDestination(pastDestination, currentAddress!);
                                Get.toNamed(AppRoutes.selectRide, arguments: {
                                  'type': 'pastDestination',
                                  'value': pastDestination.toString(),
                                  'pastHistory': pastDestination,
                                  'currentLocation': currentAddress, // Ensure this is passed if needed
                                });

                              },
                              leading: const Icon(
                                Icons.history,
                                color: historyIcon,
                              ),
                              title: Text(
                                pastDestination,
                                style:AppTextStyles.bodySmallBold.copyWith(
                                  color: searchtextGrey,
                                ),
                              ),
                            ),
                          );
                        }),
                  )
        )

            ],
          ),
        );
      },
    );
  }
}
