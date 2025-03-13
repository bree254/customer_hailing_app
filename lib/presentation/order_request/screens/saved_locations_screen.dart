import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth/controller/auth_controller.dart';
import '../controller/ride_service_controller.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  final List<Map<String, String>> _locations = [
    {'address': 'Enter Home Location', 'name': ''},
    {'address': 'Enter Work Location', 'name': ''},
  ]; // Predefined locations

  @override
  void initState() {
    super.initState();
    _fetchFrequentDestinations();
  }

  Future<void> _fetchFrequentDestinations() async {
    try {
      final customerId = Get.find<AuthController>().user.value.id;
      if (customerId != null) {
        await Get.find<RideServiceController>().getFrequentDestinations(customerId);
        final frequentDestinations = Get.find<RideServiceController>().frequentDestinations.value;

        if (frequentDestinations != null) {
          setState(() {
            _locations.addAll(frequentDestinations.data!.map((destination) => {
              'name': destination.name?.toString() ?? ' ',
              'address': destination.addressName!,
            }).toList());
          });
        }
      }
    } catch (e) {
      print('Error fetching Frequent destinations: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, String>? newLocation = Get.arguments as Map<String, String>?; // Retrieve the passed argument
    if (newLocation != null) {
      setState(() {
        if (newLocation['address'] == 'Home') {
          _locations[0] = newLocation;
        } else if (newLocation['address'] == 'Work') {
          _locations[1] = newLocation;
        } else {
          _locations.add(newLocation); // Append the new location to the list
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Saved Locations',
          style: AppTextStyles.largeAppBarText,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _locations.length + 1, // Add 1 for the "Add stop over" button
                itemBuilder: (context, index) {
                  if (index < _locations.length) {
                    final location = _locations[index];
                    return Container(
                      width: 328,
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      decoration: ShapeDecoration(
                        color: const Color(0x7FFAFAFA),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.025),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          if (location['address'] == 'Enter Home Location' || location['address'] == 'Enter Work Location') {
                            Get.toNamed(AppRoutes.searchLocation);
                          }
                        },
                        leading: Image.asset(
                          location['address'] == 'Enter Home Location'
                              ? 'assets/images/home-outline.png'
                              : location['address'] == 'Enter Work Location'
                              ? 'assets/images/briefcase-outline.png'
                              : 'assets/images/map-pin-alt-outline.png',
                          width: 24,
                          height: 24,
                        ), // Default icon for new locations
                        title: location['address']!.isNotEmpty
                            ? Text(
                          location['address']!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: darkerGrey,
                          ),
                        )
                            : null,
                        subtitle: Text(
                          location['name']!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: lighterGrey,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    );
                  } else {
                    // "Add stop over" button
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.searchLocation);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outlined, color: primaryColor, size: 14),
                            SizedBox(width: 5),
                            Text(
                              'Add a new location',
                              style: AppTextStyles.bodySmallPrimary.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}