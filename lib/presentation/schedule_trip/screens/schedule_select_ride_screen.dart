import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_status_controller.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_elevated_button.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ScheduleSelectRideScreen extends StatefulWidget {
  @override
  _ScheduleSelectRideScreenState createState() => _ScheduleSelectRideScreenState();
}

class _ScheduleSelectRideScreenState extends State<ScheduleSelectRideScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;
  String? _selectedRide;
  String? _selectedPaymentMode;
  String? _destination;
  String? _prediction;

  Set<Polyline> _polylines = {};

  final RideStatusController rideStatusController = Get.put(RideStatusController());

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> args = Get.arguments;
    if (args != null) {
      if (args['type'] == 'destination') {
        _destination = args['value'];
      } else if (args['type'] == 'prediction') {
        _prediction = args['value'];
      }
    }
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

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

    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      _updatePolyline();
    });
  }

  Future<LatLng?> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      }
    } catch (e) {
      print('Error getting coordinates from address: $e');
    }
    return null;
  }

  void _updatePolyline() async {
    if (_center != null && (_destination != null || _prediction != null)) {
      String address = _destination ?? _prediction ?? '';
      LatLng? destinationCoords = await _getCoordinatesFromAddress(address);
      if (destinationCoords != null) {
        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            visible: true,
            color: primaryColor,
            width: 5,
            points: [_center!, destinationCoords],
          ));
        });
      }
    }
  }

  void _startRideRequest() {
    rideStatusController.searchForDriver();
    Get.toNamed(AppRoutes.awaitDriver, arguments: _selectedRide);
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
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('user_location'),
                  position: _center!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                ),
              },
              polylines: _polylines,
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    hintText: _destination != null ? _destination : _prediction != null ? _prediction : 'Enter location',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        backgroundColor: searchButtonGrey),
                    border: InputBorder.none,
                    prefixIcon: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 17,
                        )),
                    suffixIcon: GestureDetector(
                      onTap:(){Get.toNamed(AppRoutes.enterScheduleTripDetails);} ,
                      child: const Icon(
                        Icons.add_circle_outlined,
                        color: primaryColor,
                        size: 17,
                      ),
                    )),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
                        height: 15,
                        thickness: 4,
                        color: lightGrey,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: MyData.requests.length,
                          itemBuilder: (context, index) {
                            var request = MyData.requests[index];
                            bool isSelected = _selectedRide == request.ridetype;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRide = request.ridetype;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? selectRideColor
                                      : const Color(0x3FFAFAFA),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? selectRideColor
                                        : Colors.black.withOpacity(0.05),
                                  ),
                                ),
                                child: ListTile(
                                  selectedColor: selectRideColor,
                                  selectedTileColor: selectRideColor,
                                  leading: Image(
                                      image: AssetImage(request.imageUrl)),
                                  title: Text(
                                    request.ridetype,
                                    style: const TextStyle(
                                      color: searchtextGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    request.timeEstimate,
                                    style: const TextStyle(
                                      color: searchtextGrey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ksh ${request.discountedPrice.toString()}',
                                        style: const TextStyle(
                                          color: searchtextGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Ksh ${request.originalprice.toString()}',
                                        style: const TextStyle(
                                            color: searchtextGrey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                            TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),

                    // Fixed part of the bottom sheet
                    Container(
                      padding: const EdgeInsets.fromLTRB(16,16,16,24),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedPaymentMode = 'Cash';
                                  });
                                },
                                child: Container(
                                  width: 72,
                                  height: 28,
                                  padding: const EdgeInsets.only(top: 4, left: 8, right: 0, bottom: 4),
                                  margin:EdgeInsets.symmetric(horizontal:10),
                                  decoration: BoxDecoration(
                                    color: _selectedPaymentMode == 'Cash'
                                        ? selectRideColor
                                        : const Color(0x3FFAFAFA),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: _selectedPaymentMode == 'Cash'
                                          ? selectRideColor
                                          : Colors.black.withOpacity(0.05),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Image(
                                        width: 13,
                                        height: 13,
                                        image: AssetImage(
                                            'assets/images/cash.png'),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Cash',
                                        style: TextStyle(
                                          color: formTextLabelColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedPaymentMode = 'Card';
                                  });
                                },
                                child: Container(
                                  width: 72,
                                  height: 28,
                                  padding: const EdgeInsets.only(top: 4, left: 8, right: 0, bottom: 4),
                                  decoration: BoxDecoration(
                                    color: _selectedPaymentMode == 'Card'
                                        ? selectRideColor
                                        : const Color(0x3FFAFAFA),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: _selectedPaymentMode == 'Card'
                                          ? selectRideColor
                                          : Colors.black.withOpacity(0.05),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Image(
                                        width: 13,
                                        height: 13,
                                        image: AssetImage(
                                            'assets/images/card.png'),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Card',
                                        style: TextStyle(
                                          color: formTextLabelColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomElevatedButton(
                            text: 'Schedule',
                            onPressed: () {
                              if (_selectedRide != null) {
                                _startRideRequest(); // Trigger the ride request
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
