import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  List<Map<String, String>> _locations = [
    {'name': 'Enter Home Location', 'address': ''},
    {'name': 'Enter Work Location', 'address': ''},
  ]; // Predefined locations

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, String>? newLocation = Get.arguments as Map<String, String>?; // Retrieve the passed argument
    if (newLocation != null) {
      setState(() {
        _locations.add(newLocation); // Append the new location to the list
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
                        color: Color(0x7FFAFAFA),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.025),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(location['name'] == 'Enter Home Location'
                            ? Icons.home_outlined
                            : location['name'] == 'Enter Work Location'
                            ? CupertinoIcons.briefcase
                            : Icons.location_on), // Default icon for new locations
                        title: Text(
                          location['name']!,
                          style: const TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: location['address']!.isNotEmpty
                            ? Text(
                          location['address']!,
                          style: const TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontSize: 10,
                          ),
                        )
                            : null,
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
