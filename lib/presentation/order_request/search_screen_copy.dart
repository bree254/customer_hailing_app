import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Stack(
        children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: MyData.destinations.length,
              itemBuilder: (context, index) {
                var destination = MyData.destinations[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB( 10,0,10 ,8),
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
                    onTap: () {
                      Get.toNamed(AppRoutes.selectRide);
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
          Positioned(
              child: Expanded(
              child: Container(
                width: 360,
                height: 198,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(),
                    top: BorderSide(),
                    right: BorderSide(),
                    bottom: BorderSide(width: 1),

                  ),
          ),
              ),
              ),
          ),
        ],
      )
    );
  }
}

