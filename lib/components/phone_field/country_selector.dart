import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

import 'country_model.dart'; // Import your country model

class CountrySelector extends StatelessWidget {
  final List<Country> countries;
  final Function(Country) onCountryChanged;

  const CountrySelector({super.key, required this.countries, required this.onCountryChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCountryPicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 15.v),
        width: 70.h,
        decoration: BoxDecoration(
          color: appTheme.grayBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 10.h),
            Image.asset(
              countries[0].flagUri,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10.h),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.white,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: countries.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(countries[index].flagUri, width: 32, height: 32),
              title: Text(countries[index].name),
              onTap: () {
                onCountryChanged(countries[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
