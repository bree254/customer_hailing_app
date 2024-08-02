import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'controller/ride_status_controller.dart';
import 'models/data.dart';

class SelectRideScreen extends StatefulWidget {
  const SelectRideScreen({super.key});

  @override
  State<SelectRideScreen> createState() => _SelectRideScreenState();
}

class _SelectRideScreenState extends State<SelectRideScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

  String? _selectedRide;
  String? _selectedPaymentMode;

//initialize the controller
  final RideStatusController rideStatusController = Get.put(RideStatusController());

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
    });
  }
//method to start the ride request that will trigger the different status updates in the search for driver method
  void _startRideRequest() {
    rideStatusController.searchForDriver();
    Get.toNamed(AppRoutes.awaitDriver, arguments: _selectedRide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _center == null
              ? const Center(child: CircularProgressIndicator())
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
              child: const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Mövenpick Residences Nairobi',
                    hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,backgroundColor: searchButtonGrey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.arrow_back),
                    suffixIcon: Icon(Icons.add_circle_outlined,color: primaryColor,)
                ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
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
                                            decoration: TextDecoration.lineThrough
                                        ),
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
                      padding: const EdgeInsets.all(16),
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
                                  padding: const EdgeInsets.only(top: 4, left: 8, right: 16, bottom: 4),
                                  decoration: BoxDecoration(
                                    color: _selectedPaymentMode == 'Cash' ? selectRideColor : const Color(0x3FFAFAFA),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: _selectedPaymentMode == 'Cash' ? selectRideColor : Colors.black.withOpacity(0.05),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Image(
                                        width: 13,
                                        height: 13,
                                        image: AssetImage('assets/images/cash.png'),
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
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedPaymentMode = 'Card';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 4, left: 8, right: 16, bottom: 4),
                                  decoration: BoxDecoration(
                                    color: _selectedPaymentMode == 'Card' ? selectRideColor : const Color(0x3FFAFAFA),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: _selectedPaymentMode == 'Card' ? selectRideColor : Colors.black.withOpacity(0.05),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Image(
                                        width: 13,
                                        height: 13,
                                        image: AssetImage('assets/images/card.png'),
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
                            text: 'select ${_selectedRide  ?? "your ride"}',
                            onPressed :(){
                              if(_selectedRide != null){
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
