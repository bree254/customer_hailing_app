import 'dart:async';

import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_status_controller.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_elevated_button.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../data/models/ride_requests/search_locations_response.dart';
import '../../../data/repos/ride_service_repository.dart';
import '../../../theme/app_text_styles.dart';
import '../controller/map_controller.dart';
import '../models/ride.dart';

class SelectRideScreen extends StatefulWidget {
  const SelectRideScreen({super.key});

  @override
  _SelectRideScreenState createState() => _SelectRideScreenState();
}

class _SelectRideScreenState extends State<SelectRideScreen> {
  String? _selectedRide;
  double ? _selectedFare;
  String? _selectedPaymentMode;
  String? _destination;
  String? _prediction;
  BitmapDescriptor? _customIcon;



  //final RideStatusController rideStatusController = Get.put(RideStatusController());
  final MapController mapController = Get.put(MapController());
  final RideServiceController rideServiceController = Get.put(RideServiceController(rideServiceRepository:  RideServiceRepository()));

  Timer? _timer;

  // Define a map to associate ride categories with their image assets
  final Map<String, String> rideCategoryImages = {
    'Economy': 'assets/images/economy.png',
    'Boda': 'assets/images/boda.png',
    'Comfort': 'assets/images/comfort.png',
    'Female': 'assets/images/economy.png',
    'Luxury': 'assets/images/economy.png',
    'XL': 'assets/images/xl_vehicle.png',
  };

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    Map<String, dynamic> args = Get.arguments;
    if (args['type'] == 'destination') {
      _destination = args['value'];
      mapController.updatePolyline(_destination!);
    } else if (args['type'] == 'prediction') {
      _prediction = args['value'];
      mapController.updatePolyline(_prediction!);
    }

  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }



  // void _startRideRequest() {
  //   rideStatusController.searchForDriver();
  //   Get.toNamed(AppRoutes.awaitDriver, arguments: _selectedRide);
  // }

  Future<void> _loadCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48),
      ),
     // 'assets/images/car_markers.png',
      'assets/images/mid_car_marker.png'
    );
    setState(() {});
  }

  Future<void> _confirmTrip() async {
    if ((_destination == null && _prediction == null) || _selectedRide == null || _selectedPaymentMode == null || _selectedFare == null) {
      Get.snackbar('Error', 'Please select all required fields.');
      return;
    }

    String dropOffAddress = _destination ?? _prediction!;
    await rideServiceController.confirmTrip(dropOffAddress, _selectedRide!, _selectedPaymentMode!, _selectedFare!);
    //_startRideRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  DrawerWidget(),
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
                ...mapController.markers,
                ...rideServiceController.availableRides.map((ride) => Marker(
                  markerId: MarkerId(ride.driverId ?? ''),
                  position: LatLng(ride.latitude ?? 0, ride.longitude ?? 0),
                  icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                 // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                )),
              },
              polylines: Set<Polyline>.of(mapController.polylines),
            ),
          )),
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
                    hintText: _destination ?? (_prediction ?? 'Enter location'),
                    hintStyle: AppTextStyles.text14Black400.copyWith(
                      color: searchtextGrey,
                    ),
                    border: InputBorder.none,
                    prefixIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 24,
                        )),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.add_circle_outlined,
                        color: primaryColor,
                        size: 24,
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
                      child: Column(
                        children: [
                          // Show the ListView for trip requests when available
                          Visibility(
                            visible: rideServiceController.fareAmounts.isNotEmpty,
                            child: Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: rideServiceController.fareAmounts.length,
                                itemBuilder: (context, index) {
                                  var request = rideServiceController.fareAmounts[index];
                                  bool isSelected = _selectedRide == request.rideCategoryName;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedRide = request.rideCategoryName;
                                        _selectedFare = request.fare;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                      decoration: BoxDecoration(
                                        color: isSelected ? selectRideColor : const Color(0x3FFAFAFA),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected ? selectRideColor : Colors.black.withOpacity(0.05),
                                        ),
                                      ),
                                      child: ListTile(
                                        selectedColor: selectRideColor,
                                        selectedTileColor: selectRideColor,
                                        leading: Image(
                                          image: AssetImage(rideCategoryImages[request.rideCategoryName] ?? 'assets/images/default.png'),
                                        ),
                                        title: Text(
                                          request.rideCategoryName.toString(),
                                          style: AppTextStyles.text14Black600.copyWith(color: searchtextGrey),
                                        ),
                                        subtitle: Text(
                                          '${request.tripDuration.toString()} min',
                                          style: AppTextStyles.text14Black400.copyWith(color: searchtextGrey, fontSize: 10.0),
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Ksh ${request.fare.toString()}',
                                              style: AppTextStyles.text14Black600.copyWith(color: searchtextGrey),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                'Ksh ${request.fare.toString()}',
                                                style: AppTextStyles.text14Black400.copyWith(
                                                  color: searchtextGrey,
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // Show the ListView for dummy data when no trip requests are available
                          Visibility(
                            visible: rideServiceController.fareAmounts.isEmpty,
                            child: Expanded(
                              child: Opacity(
                                opacity: 0.5, // Grey out the UI
                                child: ListView.builder(
                                  controller: scrollController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: MyData.requests.length,
                                  itemBuilder: (context, index) {
                                    var request = MyData.requests[index];
                                    bool isSelected = _selectedRide == request.ridetype;
                                    return GestureDetector(
                                      onTap: null, // Disable onTap when no trip requests are available
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                        decoration: BoxDecoration(
                                          color: isSelected ? selectRideColor : const Color(0x3FFAFAFA),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: isSelected ? selectRideColor : Colors.black.withOpacity(0.05),
                                          ),
                                        ),
                                        child: ListTile(
                                          selectedColor: selectRideColor,
                                          selectedTileColor: selectRideColor,
                                          leading: Image(image: AssetImage(request.imageUrl)),
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
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

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
                                  width: 72,
                                  height: 28,
                                  padding: const EdgeInsets.only(top: 4, left: 8, right: 0, bottom: 4),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                  child: Row(
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
                                        style: AppTextStyles.text14Black500.copyWith(
                                          color: formTextLabelColor,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedPaymentMode = 'Card';
                                    Get.toNamed(AppRoutes.paymentMethods);
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
                                  child: Row(
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
                                        style: AppTextStyles.text14Black500.copyWith(
                                          color: formTextLabelColor,
                                          fontSize: 10.0,
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
                            text: 'Select ${_selectedRide ?? "your ride"}',
                            onPressed: () {
                              _confirmTrip();
                              // if (_selectedRide != null) {
                              //   _startRideRequest(); // Trigger the ride request
                              //}
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