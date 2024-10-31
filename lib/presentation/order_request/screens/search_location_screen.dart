import 'dart:convert';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/predictions.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocusNode = FocusNode();
  List<Prediction> _predictions = [];

  @override
  void initState() {
    super.initState();
    _locationController.addListener(_onLocationChanged);
  }

  @override
  void dispose() {
    _locationController.removeListener(_onLocationChanged);
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  void _onLocationChanged() async {
    final query = _locationController.text;
    if (query.isNotEmpty) {
      final response = await _fetchPredictions(query);
      setState(() {
        _predictions = _parsePredictions(response);
      });
    } else {
      setState(() {
        _predictions = [];
      });
    }
  }

  Future<String> _fetchPredictions(String input) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyAFFMad-10qvSw8wZl7KgDp0jVafz4La6E',
    );
    final response = await http.get(url);
    debugPrint(jsonEncode(response.body));
    return response.body;
  }

  List<Prediction> _parsePredictions(String responseBody) {
    final json = jsonDecode(responseBody);
    final predictions = json['predictions'] as List;
    return predictions.map((p) => Prediction.fromJson(p)).toList();
  }

  void _onLocationSelected(Prediction prediction) {
    Get.toNamed(AppRoutes.nameLocation, arguments: prediction.description);
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
        title:  Text(
          'New location',
          style: AppTextStyles.largeAppBarText,
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
                itemCount: _predictions.length,
                itemBuilder: (BuildContext context, int index) {
                  final prediction = _predictions[index];
                  return Container(
                    width: 328,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                    decoration: ShapeDecoration(
                      color: const Color(0x7FFAFAFA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.02500000037252903),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        width: 24,
                        height: 24,
                        color: searchtextGrey,
                        'assets/images/map-pin-alt-outline.png',
                      ),
                      title: Text(
                        prediction.description,
                        style: const TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        _onLocationSelected(prediction);
                      },
                    ),
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

