import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
class TripStatusBottomSheet extends StatelessWidget {
  const TripStatusBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return  DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(top:8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                // clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(600),
                ),
                child: const Divider(
                  height: 20,
                  thickness: 4,
                  // color: colorwhite,
                  color: lightGrey,
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}
