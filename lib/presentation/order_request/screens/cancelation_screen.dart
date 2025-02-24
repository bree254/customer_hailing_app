import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CancelationScreen extends StatefulWidget {
  @override
  _CancelationScreenState createState() => _CancelationScreenState();
}

class _CancelationScreenState extends State<CancelationScreen> {
  int? _selectedIndex;
  TextEditingController _reasonController = TextEditingController();
  final List<String> _reasons = [
    "Driver asked me to cancel",
    "Driver is not moving",
    "Wait time too long",
    "Accidental request",
    "Wrong pickup location",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reason for cancellation?"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _reasons.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        if (_reasons[index] != "Other") {
                          _reasonController.clear();
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.purple : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          _reasons[index],
                          style: TextStyle(
                            color: isSelected ? Colors.purple : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.radio_button_checked, color: Colors.purple)
                            : Icon(Icons.radio_button_unchecked, color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_selectedIndex == _reasons.length - 1) // Show textbox only for "Other"
              TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  hintText: "Enter your reason",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle cancellation reason submission
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Done", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
