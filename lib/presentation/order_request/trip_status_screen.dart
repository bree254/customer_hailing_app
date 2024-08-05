import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class TripStatusScreen extends StatefulWidget {
  const TripStatusScreen({super.key});

  @override
  State<TripStatusScreen> createState() => _TripStatusScreenState();
}

class _TripStatusScreenState extends State<TripStatusScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
// Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
// Request permission to get the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }
// Get the current location of the user
    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          _center == null
              ? Image.asset(
            'assets/images/map.png', // Path to your cached map image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
              : SizedBox(
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center!,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('user_location'),
                  position: _center!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                ),
              },
            ),
          ),
          const TripStatusBottomSheet(),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteTextColor,
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  // Handle menu button press
                },
                color: Colors.white,
                iconSize: 30.0,
                padding: const EdgeInsets.all(10),
                tooltip: 'Open Menu',
              ),
            ),
          )
        ],
      ),
    );
  }
}
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
                                color: const Color(0xFFFAFAFA),
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
                          Get.toNamed(AppRoutes.rateRide);
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
