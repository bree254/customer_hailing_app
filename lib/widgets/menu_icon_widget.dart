import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: whiteTextColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x197B7B7B),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),BoxShadow(
            color: Color(0x167B7B7B),
            blurRadius: 1,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),BoxShadow(
            color: Color(0x0C7B7B7B),
            blurRadius: 1,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),BoxShadow(
            color: Color(0x027B7B7B),
            blurRadius: 2,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),BoxShadow(
            color: Color(0x007B7B7B),
            blurRadius: 2,
            offset: Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Handle menu button press
          },
          color: Colors.white,
          // iconSize: 42.0,
          padding: const EdgeInsets.all(10),
          tooltip: 'Open Menu',
        ),
      ),
    );
  }
}