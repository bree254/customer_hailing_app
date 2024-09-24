import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ShareWithScreen extends StatefulWidget {
  const ShareWithScreen({super.key});

  @override
  State<ShareWithScreen> createState() => _ShareWithScreenState();
}

class _ShareWithScreenState extends State<ShareWithScreen> {
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
    return Scaffold(
        drawer: const DrawerWidget(),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                        child: Text(
                          'Share with',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
                                      style: const TextStyle(
                                        color: Color(0xFF555555),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
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
