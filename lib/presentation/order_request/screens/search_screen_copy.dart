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
    _locationFocusNode.addListener(() {
      setState(() {});
    });
    _destinationFocusNode.addListener(() {
      setState(() {});
    });
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
    setState(() {
      final focusNode = FocusNode();
      focusNode.addListener(() {
        setState(() {});
      });
      _stopoverControllers.add(TextEditingController());
      _stopoverFocusNodes.add(focusNode);
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
        color: isActive ? primaryColor : disabledButtonGrey,
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
                          physics: const NeverScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              // Adjust for the static location and destination fields
                              if (oldIndex == 0 || newIndex == 0 || oldIndex == _stopoverControllers.length + 1 || newIndex == _stopoverControllers.length + 1) {
                                return;
                              }
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final TextEditingController controller = _stopoverControllers.removeAt(oldIndex - 1);
                              final FocusNode focusNode = _stopoverFocusNodes.removeAt(oldIndex - 1);
                              _stopoverControllers.insert(newIndex - 1, controller);
                              _stopoverFocusNodes.insert(newIndex - 1, focusNode);
                            });
                          },
                          children: [
                            // Location TextField
                            Padding(
                              key: const ValueKey('location'),
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  _buildDotIndicator(_locationFocusNode.hasFocus),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _locationController,
                                      focusNode: _locationFocusNode,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your location',
                                        hintStyle: const TextStyle(
                                          color: searchtextGrey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 0.14,
                                          letterSpacing: 0.25,
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
                                  ),
                                ],
                              ),
                            ),
                            // Stopover TextFields
                            for (int index = 0; index < _stopoverControllers.length; index++)
                              Padding(
                                key: ValueKey('stopover_$index'),
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    _buildDotIndicator(_stopoverFocusNodes[index].hasFocus),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        controller: _stopoverControllers[index],
                                        focusNode: _stopoverFocusNodes[index],
                                        decoration: InputDecoration(
                                          hintText: 'Enter stop ${index + 1}',
                                          hintStyle: const TextStyle(
                                            color: searchtextGrey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0.14,
                                            letterSpacing: 0.25,
                                          ),
                                          fillColor: _stopoverFocusNodes[index].hasFocus ? Colors.white : searchButtonGrey,
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
                                              if (_stopoverFocusNodes[index].hasFocus)
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                    "assets/images/location.png",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
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
                                    const Icon(Icons.drag_handle),
                                  ],
                                ),
                              ),
                            // Destination TextField
                            Padding(
                              key: const ValueKey('destination'),
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  _buildDotIndicator(_destinationFocusNode.hasFocus),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _destinationController,
                                      focusNode: _destinationFocusNode,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your destination',
                                        hintStyle: const TextStyle(
                                          color: searchtextGrey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 0.14,
                                          letterSpacing: 0.25,
                                        ),
                                        fillColor: _destinationFocusNode.hasFocus ? Colors.white : searchButtonGrey,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: primaryColor),
                                        ),
                                        suffixIcon: _destinationFocusNode.hasFocus
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
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


// import 'package:customer_hailing/core/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/data.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//
//   final FocusNode _locationFocusNode = FocusNode();
//   final FocusNode _destinationFocusNode = FocusNode();
//
//   final List<TextEditingController> _stopoverControllers = [];
//   final List<FocusNode> _stopoverFocusNodes = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _locationFocusNode.addListener(() {
//       setState(() {});
//     });
//     _destinationFocusNode.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _locationFocusNode.dispose();
//     _destinationFocusNode.dispose();
//
//     _locationController.dispose();
//     _destinationController.dispose();
//     for (var controller in _stopoverControllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _stopoverFocusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   void _addStopover() {
//     setState(() {
//       final focusNode = FocusNode();
//       focusNode.addListener(() {
//         setState(() {});
//       });
//       _stopoverControllers.add(TextEditingController());
//       _stopoverFocusNodes.add(focusNode);
//     });
//   }
//
//
//   void _removeStopover(int index) {
//     setState(() {
//       _stopoverControllers[index].dispose();
//       _stopoverFocusNodes[index].dispose();
//
//       _stopoverControllers.removeAt(index);
//       _stopoverFocusNodes.removeAt(index);
//     });
//   }
//
//   Widget _buildDotIndicator(bool isActive) {
//     return Container(
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isActive ? primaryColor : disabledButtonGrey,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             child: Column(
//               children: [
//                 AppBar(
//                   backgroundColor: Colors.white,
//                   elevation: 0,
//                   title: const Text(
//                     'Enter trip details',
//                     style: TextStyle(
//                       color: searchtextGrey,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       height: 0.10,
//                       letterSpacing: 0.25,
//                     ),
//                   ),
//                   iconTheme: const IconThemeData(color: Colors.black),
//                   leading: IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       size: 17,
//                       color: blackTextColor,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, left: 16, bottom: 8, right: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           _buildDotIndicator(_locationFocusNode.hasFocus),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: TextField(
//                               controller: _locationController,
//                               focusNode: _locationFocusNode,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter your location',
//                                 hintStyle: const TextStyle(
//                                   color: searchtextGrey,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   height: 0.14,
//                                   letterSpacing: 0.25,
//                                 ),
//                                 fillColor: _locationFocusNode.hasFocus ? Colors.white : searchButtonGrey,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: primaryColor),
//                                 ),
//                                 suffixIcon: _locationFocusNode.hasFocus
//                                     ? Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     "assets/images/location.png",
//                                     width: 24,
//                                     height: 24,
//                                   ),
//                                 )
//                                     : null,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       ..._stopoverControllers.asMap().entries.map((entry) {
//                         int index = entry.key;
//                         TextEditingController controller = entry.value;
//                         FocusNode focusNode = _stopoverFocusNodes[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: Row(
//                             children: [
//                               _buildDotIndicator(focusNode.hasFocus),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: TextField(
//                                   controller: controller,
//                                   focusNode: focusNode,
//                                   decoration: InputDecoration(
//                                     hintText: 'Enter stop ${index + 1}',
//                                     hintStyle: const TextStyle(
//                                       color: searchtextGrey,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       height: 0.14,
//                                       letterSpacing: 0.25,
//                                     ),
//                                     fillColor: focusNode.hasFocus ? Colors.white : searchButtonGrey,
//                                     filled: true,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: const BorderSide(color: primaryColor),
//                                     ),
//                                     suffixIcon: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         if (focusNode.hasFocus)
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Image.asset(
//                                               "assets/images/location.png",
//                                               width: 24,
//                                               height: 24,
//                                             ),
//                                           ),
//                                         IconButton(
//                                           icon: const Icon(Icons.cancel, color: Colors.grey),
//                                           onPressed: () => _removeStopover(index),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               const Icon(Icons.drag_handle),
//                             ],
//                           ),
//                         );
//                       }),
//                       Row(
//                         children: [
//                           _buildDotIndicator(_destinationFocusNode.hasFocus),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: TextField(
//                               controller: _destinationController,
//                               focusNode: _destinationFocusNode,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter your destination',
//                                 hintStyle: const TextStyle(
//                                   color: searchtextGrey,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   height: 0.14,
//                                   letterSpacing: 0.25,
//                                 ),
//                                 fillColor: _destinationFocusNode.hasFocus ? Colors.white : searchButtonGrey,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: primaryColor),
//                                 ),
//                                 suffixIcon: _destinationFocusNode.hasFocus
//                                     ? Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     "assets/images/location.png",
//                                     width: 24,
//                                     height: 24,
//                                   ),
//                                 )
//                                     : null,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: _addStopover,
//                         child: Container(
//                           color: Colors.transparent,
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.add_circle_outlined, color: primaryColor, size: 14),
//                               SizedBox(width: 5),
//                               Text(
//                                 'Add stop over',
//                                 style: TextStyle(
//                                   color: primaryColor,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   height: 0.14,
//                                   letterSpacing: 0.25,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Flexible(
//             child: ListView.builder(
//               itemCount: MyData.destinations.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var destination = MyData.destinations[index];
//
//                 return Container(
//                   margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
//                   decoration: ShapeDecoration(
//                     color: const Color(0x7FFAFAFA),
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(
//                         width: 1,
//                         color: Colors.black.withOpacity(0.025),
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: ListTile(
//                     onTap: () {},
//                     leading: const Icon(
//                       Icons.history,
//                       color: historyIcon,
//                     ),
//                     title: Text(
//                       destination.address,
//                       style: const TextStyle(
//                         color: searchtextGrey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     subtitle: Text(
//                       destination.location,
//                       style: const TextStyle(
//                         color: searchtextGrey,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }