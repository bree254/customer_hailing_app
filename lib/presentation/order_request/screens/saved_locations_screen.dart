import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}
class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  List<String> _locations = [
    'Enter Home Location',
    'Enter Work Location',
  ]; // Predefined locations

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the arguments passed to this route
    String? newLocationName = Get.arguments; // Get the new location name
    if (newLocationName != null && newLocationName.isNotEmpty) {
      setState(() {
        if (!_locations.contains(newLocationName)) {
          _locations.add(newLocationName); // Add new location to the list
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
        title: const Text(
          'Saved Locations',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _locations.length + 1, // Add 1 for the "Add stop over" button
                itemBuilder: (context, index) {
                  if (index < _locations.length) {
                    return Container(
                      width: 328,
                      height: 56,
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      decoration: ShapeDecoration(
                        color: Color(0x7FFAFAFA),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.025),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(_locations[index] == 'Enter Home Location'
                              ? Icons.home_outlined
                              : _locations[index] == 'Enter Work Location'
                              ? CupertinoIcons.briefcase
                              : Icons.location_on), // Default icon for new locations
                          SizedBox(width: 16),
                          Text(
                            _locations[index],
                            style: TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    // "Add stop over" button
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.searchLocation);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                        color: Colors.transparent,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outlined, color: primaryColor, size: 14),
                            SizedBox(width: 5),
                            Text(
                              'Add stop over',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 0.14,
                                letterSpacing: 0.25,
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





