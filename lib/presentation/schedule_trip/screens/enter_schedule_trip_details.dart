import 'dart:convert';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import '../../order_request/models/data.dart';
import '../../order_request/models/predictions.dart';
import 'package:http/http.dart' as http;

class EnterScheduleTripDetailsScreen extends StatefulWidget {
  const EnterScheduleTripDetailsScreen({super.key});

  @override
  State<EnterScheduleTripDetailsScreen> createState() => _EnterScheduleTripDetailsScreenState();
}

class _EnterScheduleTripDetailsScreenState extends State<EnterScheduleTripDetailsScreen> {
  final String googleApiKey = "AIzaSyAFFMad-10qvSw8wZl7KgDp0jVafz4La6E";
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<Prediction> _predictions = [];
  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();
  final List<TextEditingController> _stopoverControllers = [];
  final List<FocusNode> _stopoverFocusNodes = [];
  final RxBool _isTyping = false.obs;

  @override
  void initState() {
    super.initState();

    // Retrieve the date and time arguments
    final arguments = Get.arguments as Map<String, String>;
    final date = arguments['date'];
    final time = arguments['time'];

    // Add listeners to detect typing
    _locationController.addListener(_onTextChanged);
    _destinationController.addListener(_onTextChanged);
    _locationFocusNode.addListener(_onFocusChange);
    _destinationFocusNode.addListener(_onFocusChange);
    _locationController.addListener(_onLocationChanged);
    _destinationController.addListener(_onLocationChanged);

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

    // Add listeners to detect focus changes and clear predictions
    for (var focusNode in _stopoverFocusNodes) {
      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          setState(() {
            _predictions = [];
          });
        }
      });
    }
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

  void _onTextChanged() {
    setState(() {
      _isTyping.value = _locationController.text.isNotEmpty ||
          _destinationController.text.isNotEmpty ||
          _stopoverControllers.any((controller) => controller.text.isNotEmpty);
    });
  }

  void _onFocusChange() {
    setState(() {
      _isTyping.value = _locationFocusNode.hasFocus ||
          _destinationFocusNode.hasFocus ||
          _stopoverFocusNodes.any((focusNode) => focusNode.hasFocus);
    });
  }

  void _onLocationChanged() async {
    if (_locationFocusNode.hasFocus) {
      final locationQuery = _locationController.text;
      if (locationQuery.isNotEmpty) {
        final response = await _fetchPredictions(locationQuery);
        setState(() {
          _predictions = _parsePredictions(response);
        });
      } else {
        setState(() {
          _predictions = [];
        });
      }
    } else if (_destinationFocusNode.hasFocus) {
      final destinationQuery = _destinationController.text;
      if (destinationQuery.isNotEmpty) {
        final response = await _fetchPredictions(destinationQuery);
        setState(() {
          _predictions = _parsePredictions(response);
        });
      } else {
        setState(() {
          _predictions = [];
        });
      }
    } else {
      for (int i = 0; i < _stopoverControllers.length - 1; i++) {
        if (_stopoverFocusNodes[i].hasFocus) {
          final stopoverQuery = _stopoverControllers[i].text;
          if (stopoverQuery.isNotEmpty) {
            final response = await _fetchPredictions(stopoverQuery);
            setState(() {
              _predictions = _parsePredictions(response);
            });
          } else {
            setState(() {
              _predictions = [];
            });
          }
          break;
        }
      }
    }
  }

  Future<String> _fetchPredictions(String input) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey&components=country:ke',
    );
    final response = await http.get(url);
    return response.body;
  }

  List<Prediction> _parsePredictions(String responseBody) {
    final json = jsonDecode(responseBody);
    final predictions = json['predictions'] as List;
    return predictions.map((p) => Prediction.fromJson(p)).toList();
  }

  // void _onPredictionSelected(Prediction prediction) {
  //   Get.toNamed(AppRoutes.scheduleSelectRide, arguments: {
  //     'type': 'prediction',
  //     'value': prediction.description,
  //     'date': Get.arguments['date'],
  //     'time': Get.arguments['time'],
  //   });
  // }

  void _onPredictionSelected(Prediction prediction) {
    if (_locationController.text.isNotEmpty && _destinationController.text.isNotEmpty) {
      Get.toNamed(AppRoutes.scheduleSelectRide, arguments: {
        'location': _locationController.text,
        'destination': _destinationController.text,
        'date': Get.arguments['date'],
        'time': Get.arguments['time'],
      });
    } else {
      setState(() {
        if (_locationFocusNode.hasFocus) {
          _locationController.text = prediction.description;
          _locationFocusNode.unfocus();
        } else if (_destinationFocusNode.hasFocus) {
          _destinationController.text = prediction.description;
          _destinationFocusNode.unfocus();
        }
      });
    }
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
                  color: dotGrey,
                ),
              _buildDotIndicator(focusNode.hasFocus),
              if (index != _stopoverControllers.length - 1)
                Container(
                  width: 2,
                  height: 20,
                  color: dotGrey,
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
                hintStyle: AppTextStyles.bodySmallBold.copyWith(
                  color: searchtextGrey,
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
        title: Text(
          'Enter trip details',
          style: AppTextStyles.mediumAppBarText,
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outlined, color: primaryColor, size: 14),
                              SizedBox(width: 5),
                              Text(
                                'Add stop over',
                                style: AppTextStyles.bodySmallPrimary.copyWith(
                                  fontWeight: FontWeight.w400,
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
          Expanded(
            child: Obx(() => !_isTyping.value
                ? ListView.builder(
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
                      if (_destinationFocusNode.hasFocus) {
                        _destinationController.text = destination.address;
                        _destinationFocusNode.requestFocus();
                      } else if (_locationFocusNode.hasFocus) {
                        _locationController.text = destination.address;
                        _locationFocusNode.requestFocus();
                      } else {
                        for (int i = 1; i < _stopoverControllers.length - 1; i++) {
                          if (_stopoverFocusNodes[i].hasFocus) {
                            _stopoverControllers[i].text = destination.address;
                            _stopoverFocusNodes[i].requestFocus();
                            break;
                          }
                        }
                      }
                    },
                    leading: const Icon(
                      Icons.history,
                      color: historyIcon,
                    ),
                    title: Text(
                      destination.address,
                      style: AppTextStyles.bodySmallBold.copyWith(
                        color: searchtextGrey,
                      ),
                    ),
                    subtitle: Text(
                      destination.location,
                      style: AppTextStyles.bodySmallBold.copyWith(
                        color: searchtextGrey,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                );
              },
            )
                : ListView.builder(
              itemCount: _predictions.length,
              itemBuilder: (BuildContext context, int index) {
                final prediction = _predictions[index];
                return Container(
                  width: 328,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                    leading: Image.asset(
                      width: 24,
                      height: 24,
                      color: searchtextGrey,
                      'assets/images/map-pin-alt-outline.png',
                    ),
                    title: Text(
                      prediction.description,
                      style: AppTextStyles.bodySmallBold.copyWith(
                        color: searchtextGrey,
                      ),
                    ),
                    onTap: () {
                      final selectedPrediction = prediction.description;
                      if (_locationFocusNode.hasFocus) {
                        _locationController.text = selectedPrediction;
                        _locationFocusNode.unfocus();
                      } else if (_destinationFocusNode.hasFocus) {
                        _destinationController.text = selectedPrediction;
                        _destinationFocusNode.unfocus();
                      } else {
                        for (int i = 1; i < _stopoverControllers.length - 1; i++) {
                          if (_stopoverFocusNodes[i].hasFocus) {
                            _stopoverControllers[i].text = selectedPrediction;
                            _stopoverFocusNodes[i].unfocus();
                            break;
                          }
                        }
                      }
                      setState(() {
                        _predictions = [];
                      });
                      _onPredictionSelected(prediction);
                    },
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}