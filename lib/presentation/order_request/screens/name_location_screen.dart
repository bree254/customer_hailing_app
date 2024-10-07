import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameLocationScreen extends StatefulWidget {
  const NameLocationScreen({super.key});

  @override
  State<NameLocationScreen> createState() => _NameLocationScreenState();
}

class _NameLocationScreenState extends State<NameLocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocusNode = FocusNode();
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _locationController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _locationController.removeListener(_onTextChanged);
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasInput = _locationController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Give the location a name',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              focusNode: _locationFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter place name',
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
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: _hasInput
                  ? () {
                final name = _locationController.text;
                final address = Get.arguments as String; // Get the passed address
                Get.toNamed(AppRoutes.savedLocation,
                    arguments: {'name': name, 'address': address});
              }
                  : null, // Disable button if no input
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: _hasInput ? primaryColor : disabledButtonGrey, // Change color based on input
                elevation: 0,
              ),
              buttonTextStyle: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              text: 'Next',
            ),

          ],
        ),
      ),
    );
  }
}
