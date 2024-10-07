import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_status_controller.dart';
import 'package:customer_hailing/widgets/await_driver_bottomsheet_widget.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AwaitDriverScreen extends StatefulWidget {
  const AwaitDriverScreen({super.key});

  @override
  State<AwaitDriverScreen> createState() => _AwaitDriverScreenState();
}

class _AwaitDriverScreenState extends State<AwaitDriverScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

  bool isSelected = false;

  final RideStatusController rideStatusController = Get.put(RideStatusController());


  @override
  void initState() {
    super.initState();
    //_getUserLocation();
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
      body:Stack(
        children :[
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
