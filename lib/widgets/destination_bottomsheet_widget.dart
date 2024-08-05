import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
class DestinationBottomSheet extends StatelessWidget {
  const DestinationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // final RideRequestController controller = Get.find<RideRequestController>();

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
                  Get.toNamed(AppRoutes.search);
                },
                child: Container(
                  margin:
                  const EdgeInsets.fromLTRB( 10, 8,10,0),
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'where do you want to go',
                        labelStyle: const TextStyle(
                          color: searchtextGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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
                  child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: MyData.destinations.length,
                      itemBuilder: (context, index) {
                        var destination = MyData.destinations[index];
                        return Container(
                          margin: const EdgeInsets.fromLTRB( 10,0,10 ,8),
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
                            onTap: () {
                              Get.toNamed(AppRoutes.selectRide);
                            },
                            leading: const Icon(
                              Icons.history,
                              color: historyIcon,
                            ),
                            title: Text(
                              destination.address,
                              style: const TextStyle(
                                color: searchtextGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              destination.location,
                              style: const TextStyle(
                                color: searchtextGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }))

              // Expanded(
              //   child: Obx(
              //         () => ListView.builder(
              //       controller: scrollController,
              //       itemCount: controller.destinations.length,
              //       itemBuilder: (context, index) {
              //         final destination = controller.destinations[index];
              //         return Card(
              //           child: ListTile(
              //             title: Text(destination.name),
              //             subtitle: Text(destination.address),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
