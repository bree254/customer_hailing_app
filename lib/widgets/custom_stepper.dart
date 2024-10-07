import 'package:flutter/material.dart';

class CustomStepperWidget extends StatelessWidget {
  final List<CustomStep> steps;
  final int activeStep;

  const CustomStepperWidget({super.key, required this.steps, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.expand((entry) {
        int idx = entry.key;
        CustomStep step = entry.value;

        // Color logic: green for first step, purple for second step
        Color stepColor;
        if (idx == 0) {
          stepColor = Colors.green;  // Green for the first step
        } else if (idx == 1) {
          stepColor = Colors.purple;  // Purple for the second step
        } else {
          stepColor = idx <= activeStep ? Colors.green : Colors.grey;  // Adjust color based on active step
        }

        return [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator (ring with a white center)
              Column(
                children: [
                  Container(
                    height: 24.0,  // Outer circle (ring) size
                    width: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: stepColor,  // The color of the ring
                        width: 3.0,        // The thickness of the ring
                      ),
                      color: Colors.white,  // Inner white circle
                    ),
                    child: Center(
                      child: Container(
                        height: 12.0,  // Inner white circle size
                        width: 12.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: stepColor,  // Color for inner circle when active, or grey when inactive
                        ),
                      ),
                    ),
                  ),
                  // Connector line if not the last item
                  if (idx < steps.length - 1)
                    Container(
                      width: 2.0,
                      height: 60.0, // Adjust line height to match your design
                      color: Colors.grey,
                    ),
                ],
              ),
              const SizedBox(width: 16), // Adjust space between the dot and the text

              // Step text (title and subtitle)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: const TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      step.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),)
                  ],
                ),
              ),
            ],
          ),
        ];
      }).toList(),
    );
  }
}

class CustomStep {
  final String title;
  final String subtitle;
  final VoidCallback? onEdit;

  CustomStep({
    required this.title,
    required this.subtitle,
    this.onEdit,
  });
}