import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final List<TextEditingController> _stopoverControllers = [];
  final List<FocusNode> _stopoverFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _locationController.dispose();
    _destinationController.dispose();
    for (var controller in _stopoverControllers) {
      controller.dispose();
    }
    for (var focusNode in _stopoverFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _addStopover() {
    setState(() {
      _stopoverControllers.add(TextEditingController());
      _stopoverFocusNodes.add(FocusNode());
    });
  }

  void _removeStopover(int index) {
    setState(() {
      _stopoverControllers[index].dispose();
      _stopoverFocusNodes[index].dispose();
      _stopoverControllers.removeAt(index);
      _stopoverFocusNodes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text(
                    'Enter trip details',
                    style: TextStyle(
                      color: searchtextGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.25,
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, bottom: 8, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _locationController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: 'Enter your location',
                          hintStyle: const TextStyle(
                            color: searchtextGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0.14,
                            letterSpacing: 0.25,
                          ),
                          fillColor: _focusNode.hasFocus ? Colors.white : searchButtonGrey,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          suffixIcon: _focusNode.hasFocus
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
                      const SizedBox(height: 20),
                      ..._stopoverControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        TextEditingController controller = entry.value;
                        FocusNode focusNode = _stopoverFocusNodes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Enter stop ${index + 1}',
                                    hintStyle: const TextStyle(
                                      color: searchtextGrey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0.14,
                                      letterSpacing: 0.25,
                                    ),
                                    fillColor: _focusNode.hasFocus ? Colors.white : searchButtonGrey,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: primaryColor),
                                    ),
                                    suffixIcon: focusNode.hasFocus
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
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel, color: disabledButtonGrey),
                                onPressed: () => _removeStopover(index),
                              ),
                            ],
                          ),
                        );
                      }),
                      TextField(
                        controller: _destinationController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: 'Enter your destination',
                          hintStyle: const TextStyle(
                            color: searchtextGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0.14,
                            letterSpacing: 0.25,
                          ),
                          fillColor: _focusNode.hasFocus ? Colors.white : searchButtonGrey,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          suffixIcon: _focusNode.hasFocus
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
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _addStopover,
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: MyData.destinations.length,
              itemBuilder: (BuildContext context, int index) {
                var destination = MyData.destinations[index];

                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
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
                    onTap: () {},
                    leading: const Icon(
                      Icons.history,
                      color: historyIcon,
                    ),
                    title: Text(
                      destination.address,
                      style: const TextStyle(
                        color: searchtextGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      destination.location,
                      style: const TextStyle(
                        color: searchtextGrey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

