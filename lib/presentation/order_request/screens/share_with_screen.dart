import 'package:customer_hailing/core/app_export.dart';
  import 'package:customer_hailing/data/repos/ride_service_repository.dart';
  import 'package:customer_hailing/routes/routes.dart';
  import 'package:customer_hailing/widgets/drawer_widget.dart';
  import 'package:customer_hailing/widgets/menu_icon_widget.dart';
  import 'package:flutter/material.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:flutter_contacts/flutter_contacts.dart';
  import 'package:url_launcher/url_launcher.dart';
  import 'package:permission_handler/permission_handler.dart';

  import '../controller/map_controller.dart';
  import '../controller/ride_service_controller.dart';

  class ShareWithScreen extends StatefulWidget {
    const ShareWithScreen({super.key});

    @override
    State<ShareWithScreen> createState() => _ShareWithScreenState();
  }

  class _ShareWithScreenState extends State<ShareWithScreen> {
    final MapController mapController = Get.put(MapController());
    final RideServiceController rideServiceController = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));
    List<Contact> contacts = [];
    bool isLoading = true;
    String? shareableLink;

    @override
    void initState() {
      super.initState();
      _requestPermissions();
      _generateShareableLink();
    }

    Future<void> _requestPermissions() async {
      if (await Permission.contacts.request().isGranted) {
        _fetchContacts();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }

    Future<void> _fetchContacts() async {
      try {
        if (await Permission.contacts.request().isGranted) {
          final List<Contact> contactsList = await FlutterContacts.getContacts(withProperties: true);
          setState(() {
            contacts = contactsList;
            isLoading = false;
          });
          print('Contacts fetched successfully: ${contactsList.length}');
        } else {
          setState(() {
            isLoading = false;
          });
          print('Contacts permission denied');
        }
      } catch (e) {
        // Handle error
        setState(() {
          isLoading = false;
        });
        print('Error fetching contacts: $e');
      }
    }

    Future<void> _generateShareableLink() async {
      shareableLink = await rideServiceController.shareTrip();
    }

    Future<void> _sendSMS(String phoneNumber, String message) async {
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: <String, String>{'body': message},
      );
      if (await canLaunch(smsUri.toString())) {
        await launch(smsUri.toString());
      } else {
        // Handle error
      }
    }

    String _getInitials(String name) {
      List<String> nameParts = name.split(' ');
      if (nameParts.length > 1) {
        return nameParts[0][0] + nameParts[1][0];
      } else {
        return nameParts[0][0];
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
                markers: mapController.markers,
                polylines: mapController.polylines,
              ),
            )),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Text(
                          'Share with',
                          style: AppTextStyles.bodyHeading,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final contact = contacts[index];
                              final phoneNumber = contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : null;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: phoneNumber != null && shareableLink != null
                                          ? () {
                                        _sendSMS(phoneNumber!, 'Check out my ride details: $shareableLink');
                                      }
                                          : null,
                                      child: CircleAvatar(
                                        radius: 26,
                                        child: Text(
                                          _getInitials(contact.displayName ?? 'Unknown'),
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                        backgroundColor: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      contact.displayName ?? 'Unknown',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: darkerGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
                  return MenuIconWidget(onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
  }