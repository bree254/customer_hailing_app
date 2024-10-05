import 'package:customer_hailing/widgets/destination_bottomsheet_widget.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:customer_hailing/widgets/menu_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


// Existing method in your HomeScreen's _HomeScreenState class
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

    if (_currentPosition != null) {
      _center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

      // Convert coordinates to a human-readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = placemarks[0];
      _currentAddress = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      setState(() {});
    }
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
        DestinationBottomSheet(currentAddress: _currentAddress),
         Positioned(
          top: 40,
          left: 20,
          child: Builder(
            builder: (context) {
              return MenuIconWidget(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },

              );
            }
          ),
        )
      ],
    ));
  }
}


