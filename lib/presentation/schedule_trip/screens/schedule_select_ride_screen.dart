import 'dart:async';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_elevated_button.dart';
import 'package:customer_hailing/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../theme/app_text_styles.dart';
import '../../order_request/controller/map_controller.dart';
import '../../../data/repos/ride_service_repository.dart';

class ScheduleSelectRideScreen extends StatefulWidget {
  const ScheduleSelectRideScreen({super.key});

  @override
  _ScheduleSelectRideScreenState createState() =>
      _ScheduleSelectRideScreenState();
}

class _ScheduleSelectRideScreenState extends State<ScheduleSelectRideScreen> {
  String? _selectedRide;
  double? _selectedFare;
  String? _selectedPaymentMode;
  String? _destination;
  String? _prediction;
  BitmapDescriptor? _customIcon;

  final MapController mapController = Get.put(MapController());
  final RideServiceController rideServiceController = Get.put(
      RideServiceController(rideServiceRepository: RideServiceRepository()));

  // Define a map to associate ride categories with their image assets
  final Map<String, String> rideCategoryImages = {
    'Economy': 'assets/images/economy_car.png',
    'Boda': 'assets/images/normal_boda.png',
    'Female': 'assets/images/female_car.png',
    'Luxury': 'assets/images/luxury_car.png',
    'Standard': 'assets/images/standard_car.png',
    'XL': 'assets/images/xl_car.png',
  };

  // @override
  // void initState() {
  //   super.initState();
  //   _loadCustomIcon();
  //   final arguments = Get.arguments as Map<String, dynamic>;
  //   _destination = arguments['destination'] as String?;
  //   //mapController.updatePolyline(_destination!);
  //   _prediction = arguments['location'] as String?;
  //  // mapController.updatePolyline(_prediction!);
  // }

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    final arguments = Get.arguments as Map<String, dynamic>;
    _destination = arguments['destination'] as String?;
    debugPrint('schedule trip destination: $_destination');
    _prediction = arguments['location'] as String?;
    debugPrint('schedule trip location: $_prediction');

    // Call updatePolyline with both origin and destination addresses
    if (_prediction != null && _destination != null) {
      mapController.updatePolylines(_prediction!, _destination!);
    }
  }

  Future<void> _loadCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/mid_car_marker.png',
    );
    setState(() {});
  }

  Future<void> _scheduleTrip() async {
    final arguments = Get.arguments as Map<String, dynamic>;
    final date = arguments['date'] as String?;
    final time = arguments['time'] as String?;
    final location = arguments['location'] as String?;
    final destination = arguments['destination'] as String?;

    if (_selectedRide != null && _selectedPaymentMode != null) {
      final selectedRide = rideServiceController.fareAmounts
          .firstWhere((request) => request.rideCategoryName == _selectedRide);
      final estimatedFare = selectedRide.fare;

      await rideServiceController.scheduleTrip(
        location!,
        destination!,
        _selectedRide!,
        estimatedFare!,
        _selectedPaymentMode!,
        date!,
        time!,
      );
    } else {
      Get.snackbar('Error', 'Please select a ride and payment method.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
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
                      Marker(
                        markerId: const MarkerId('user_location'),
                        position: mapController.center.value!,
                        infoWindow: const InfoWindow(title: 'Your Location'),
                      ),
                    },
                    polylines: mapController.polylines,
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  hintText: _destination ?? (_prediction ?? 'Enter location'),
                  hintStyle: AppTextStyles.text14Black400
                      .copyWith(color: searchtextGrey),
                  border: InputBorder.none,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.search);
                    },
                    child: const Icon(
                      Icons.add_circle_outlined,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
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
                        itemCount: rideServiceController.fareAmounts.length,
                        itemBuilder: (context, index) {
                          var request =
                              rideServiceController.fareAmounts[index];
                          bool isSelected =
                              _selectedRide == request.rideCategoryName;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRide = request.rideCategoryName;
                                _selectedFare = request.fare;
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
                                  image: AssetImage(rideCategoryImages[
                                          request.rideCategoryName] ??
                                      'assets/images/default.png'),
                                ),
                                title: Text(
                                  request.rideCategoryName.toString(),
                                  style: AppTextStyles.text14Black600
                                      .copyWith(color: searchtextGrey),
                                ),
                                subtitle: Text(
                                  '${request.tripDuration.toString()} min',
                                  style: AppTextStyles.text14Black400.copyWith(
                                      color: searchtextGrey, fontSize: 10.0),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ksh ${request.fare.toString()}',
                                      style: AppTextStyles.text14Black600
                                          .copyWith(color: searchtextGrey),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        'Ksh ${request.fare.toString()}',
                                        style: AppTextStyles.text14Black400
                                            .copyWith(
                                          color: searchtextGrey,
                                          decoration:
                                              TextDecoration.lineThrough,
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
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 8, right: 0, bottom: 4),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                        style: AppTextStyles.text14Black500
                                            .copyWith(
                                                color: formTextLabelColor,
                                                fontSize: 10.0),
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
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 8, right: 0, bottom: 4),
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
                                        style: AppTextStyles.text14Black500
                                            .copyWith(
                                                color: formTextLabelColor,
                                                fontSize: 10.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomElevatedButton(
                            text: 'Schedule',
                            onPressed: _scheduleTrip,
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
