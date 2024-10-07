import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final List<CustomStep> steps;
  final int activeStep;

  const CustomStepper({super.key, required this.steps, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.expand((entry) {
        int idx = entry.key;
        CustomStep step = entry.value;

        return [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator (dot)
                    Container(
                      height: 12.0,
                      width: 12.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: idx <= activeStep ? primaryColor : Colors.grey,
                      ),
                    ),
                const SizedBox(width: 20), // Space between the dot and the text

                // Step text (title and subtitle)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        step.subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Edit button
                GestureDetector(
                  onTap: step.onEdit, // A function to handle editing
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (idx < steps.length - 1)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              height: 30.0,
              width: 2.0,
              color: const Color(0xFFD9D9D9),
            ),
        ];
      }).toList(),
    );
  }
}

class CustomStep {
  final String title;
  final String subtitle;
  final VoidCallback? onEdit; // Callback for the "Edit" button

  CustomStep({
    required this.title,
    required this.subtitle,
    this.onEdit,
  });
}