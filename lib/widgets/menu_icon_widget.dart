import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: whiteTextColor,
      ),
      child: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          // Handle menu button press
        },
        color: Colors.white,
        iconSize: 30.0,
        padding: const EdgeInsets.all(10),
        tooltip: 'Open Menu',
      ),
    );
  }
}