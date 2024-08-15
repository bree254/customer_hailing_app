import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();

  final List<TextEditingController> _stopoverControllers = [];
  final List<FocusNode> _stopoverFocusNodes = [];

  @override
  void initState() {
    super.initState();

    // Retrieve the current location passed from DestinationBottomSheet
    final currentAddress = Get.arguments as String?;
    if (currentAddress != null) {
      _locationController.text = currentAddress;
    }

    _locationFocusNode.addListener(() {
      setState(() {});
    });
    _destinationFocusNode.addListener(() {
      setState(() {});
    });

    // Add location controller and focus node
    _stopoverControllers.add(_locationController);
    _stopoverFocusNodes.add(_locationFocusNode);

    _stopoverControllers.add(_destinationController);
    _stopoverFocusNodes.add(_destinationFocusNode);
  }

  @override
  void dispose() {
    _locationFocusNode.dispose();
    _destinationFocusNode.dispose();

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
    if (_stopoverControllers.length - 2 >= 2) {
      return; // Maximum of 2 stopovers
    }
    setState(() {
      final focusNode = FocusNode();
      focusNode.addListener(() {
        setState(() {});
      });
      _stopoverControllers.insert(_stopoverControllers.length - 1, TextEditingController());
      _stopoverFocusNodes.insert(_stopoverFocusNodes.length - 1, focusNode);
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

  Widget _buildDotIndicator(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? primaryColor : dotGrey,
      ),
    );
  }

  Widget _buildTextField(int index) {
    TextEditingController controller = _stopoverControllers[index];
    FocusNode focusNode = _stopoverFocusNodes[index];
    bool isLocation = index == 0;
    bool isDestination = index == _stopoverControllers.length - 1;
    bool isStopover = !isLocation && !isDestination;

    return Padding(
      key: ValueKey('stopover_$index'),
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Column(
            children: [
              if (index != 0)
                Container(
                  width: 2,
                  height: 20,
                  color: dotGrey, // Change color as needed
                ),
              _buildDotIndicator(focusNode.hasFocus),
              if (index != _stopoverControllers.length - 1)
                Container(
                  width: 2,
                  height: 20,
                  color: dotGrey, // Change color as needed
                ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: isLocation
                    ? 'Enter your location'
                    : isDestination
                    ? 'Enter your destination'
                    : 'Enter stop $index',
                hintStyle: const TextStyle(
                  color: searchtextGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: focusNode.hasFocus ? Colors.white : searchButtonGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (focusNode.hasFocus)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/location.png",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    if (isStopover)
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () => _removeStopover(index),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isStopover || (_stopoverControllers.length > 2 && isDestination))
            const Icon(Icons.drag_handle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Enter trip details',
          style: TextStyle(
            color: searchtextGrey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
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
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, bottom: 8, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: ReorderableListView(
                          // physics: const NeverScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final TextEditingController controller = _stopoverControllers.removeAt(oldIndex);
                              final FocusNode focusNode = _stopoverFocusNodes.removeAt(oldIndex);
                              _stopoverControllers.insert(newIndex, controller);
                              _stopoverFocusNodes.insert(newIndex, focusNode);
                            });
                          },
                          children: _stopoverControllers.asMap().entries.map((entry) {
                            int index = entry.key;
                            return _buildTextField(index);
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: _addStopover,
                        child: Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.symmetric(vertical: 10),
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
                      const SizedBox(height: 10),
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
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                      if(_destinationFocusNode.hasFocus){
                        // Update the destination controller with the selected destination
                        _destinationController.text = destination.address;
                        // Optionally, move focus to the destination text field
                        _destinationFocusNode.requestFocus();

                      }else if(_locationFocusNode.hasFocus){
                        // Update the location controller with the selected location
                        _locationController.text = destination.address;
                        // Optionally, move focus to the location text field
                        _locationFocusNode.requestFocus();
                      }
                    },
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
