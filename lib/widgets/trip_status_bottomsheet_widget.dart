import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TripStatusBottomSheet extends StatelessWidget {
  const TripStatusBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(600),
                  ),
                  child: const Divider(
                    height: 20,
                    thickness: 4,
                    color: lightGrey,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Center(
                    child: Text(
                      'Your driver is on the way!',
                      style: TextStyle(
                        color: Color(0xFF7145D6),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Stack(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.transparent,
                              child: Image(
                                image: AssetImage("assets/images/driver.png"),
                                fit: BoxFit.cover,
                                width: 45,
                                height: 45,
                              ),
                          ),
                          Positioned(
                            top: 29,
                            left: 5,
                            child: Container(
                              width: 34,
                              height: 18,
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                color: Color(0xFFFAFAFA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/star.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '4.85',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF7B7B7B),
                                      fontSize: 6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      title: const Text(
                        'James Smith',
                        style: TextStyle(
                          color: Color(0xFF434343),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'White, Mazda Demio',
                            style: TextStyle(
                              color: Color(0xFF434343),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'KCZ 123A',
                            style: TextStyle(
                              color: Color(0xFF7145D6),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                        Image(image: AssetImage("assets/images/mazda.png")),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: selectRideColor),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 17,
                                ),
                                Text(
                                  'Message',
                                  style: TextStyle(
                                    color: Color(0xFF7145D6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: selectRideColor),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 17,
                                ),
                                Text(
                                  'Call driver',
                                  style: TextStyle(
                                    color: Color(0xFF7145D6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const ListTile(
                        leading: Icon(
                          Icons.circle_outlined,
                          size: 12,
                          color: primaryColor,
                        ),
                        title: Text(
                          'GPO Stage, Kenyatta Avenue',
                          style: TextStyle(
                            color: formTextLabelColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    const ListTile(
                      leading: Icon(
                        Icons.add_circle_outlined,
                        size: 14,
                        color: primaryColor,
                      ),
                      title: Text(
                        'Add stop over',
                        style: TextStyle(
                          color: disabledText,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        size: 14,
                        color: primaryColor,
                      ),
                      title: const Text(
                        'Mövenpick Residences Nairobi',
                        style: TextStyle(
                          color: formTextLabelColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Text(
                        'Change ',
                        style: TextStyle(
                          color: trailertext,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        // Handle destination change
                      },
                    ),
                    ListTile(
                      leading: Image.asset(
                          width: 21, height: 22, "assets/images/cash.png"),
                      title: const Text(
                        'Total cost',
                        style: TextStyle(
                          color: Color(0xFF434343),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Text(
                        'Ksh 450',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: formTextLabelColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: CustomElevatedButton(
                        onPressed: () {
                          // Handle cancel
                        },
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: cancelButton,
                        ),
                        buttonTextStyle: const TextStyle(
                            color: cancelText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        text: 'Cancel trip',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
