import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocusNode = FocusNode();
  List<String> _suggestions = [];

  final List<String> _allocations =[
    'Cavalli', 'ABC place', 'Bar Next Door', 'GPO stage', 'Alchemist',
    'Blue Hills Academy', 'I&M Bank House ', 'Fortis Suite', 'Vibanda Village', 'Moi Avenue'
  ];
  final List<String> _allocationsDesc =[
    'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya',
    'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya', 'Westlands Road, Nairobi, Kenya','Westlands Road, Nairobi, Kenya'
  ];

  @override
  void initState(){
    super.initState();
    _locationController.addListener((_onLocationChanged));
  }
  @override
  void dispose() {
    _locationController.removeListener(_onLocationChanged);
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  void _onLocationChanged() {
    final query = _locationController.text.toLowerCase();
    if (query.isNotEmpty) {
      setState(() {
        _suggestions = _allocations
            .where((location) => location.toLowerCase().contains(query))
            .toList();
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  void _onLocationSelected(String location) {
    Get.toNamed(AppRoutes.nameLocation);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
           CupertinoIcons.multiply,
            size: 17,
            color: blackTextColor,
          ),
        ),
        title: const Text(
          'New location',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              focusNode: _locationFocusNode,
              decoration: InputDecoration(
                hintText: 'Search location',
                hintStyle: const TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: _locationFocusNode.hasFocus ? Colors.white : searchButtonGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                suffixIcon: _locationFocusNode.hasFocus
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/location.png",
                    width: 24,
                    height: 24,
                  ),
                )
                    : null,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  var location = _suggestions[index];
                  var description = _allocationsDesc[_allocations.indexOf(location)];
                  return Container(
                    width: 328,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                    decoration: ShapeDecoration(
                      color: Color(0x7FFAFAFA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.02500000037252903),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:ListTile(
                      leading:  Image.asset(
                          width: 24,
                          height: 24,
                          color: searchtextGrey,
                          'assets/images/map-pin-alt-outline.png'
                      ),
                      title: Text(
                        location,
                        style: TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        description,
                        style: TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        _onLocationSelected(location);
                      },
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
