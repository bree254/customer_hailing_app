import 'package:customer_hailing/components/phone_field/phone_controller.dart';
import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'country_model.dart';
import 'country_selector.dart';


class CustomPhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? customValidator;
  final Function(String)? onInputChanged;
  InputBorder? inputBorder;
  String? errorMessage;

  CustomPhoneInput({
    super.key,
    required this.controller,
    this.customValidator,
    this.onInputChanged,
    this.inputBorder,
    this.errorMessage,
  });

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  Country? selectedCountry;

  List<Country> countries = [
    Country(
      name: 'Kenya',
      dialCode: '+254',
      alpha2Code: 'KE',
      flagUri: 'assets/flags/ke.png',
    ),
    Country(
      name: 'Uganda',
      dialCode: '+256',
      alpha2Code: 'UG',
      flagUri: 'assets/flags/ug.png',
    ),
    Country(
      name: 'Tanzania',
      dialCode: '+255',
      alpha2Code: 'TZ',
      flagUri: 'assets/flags/tz.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  //load countries
  loadCountries() async {
    List<Country> countries = PhoneController.getCountriesData();
    setState(() {
      this.countries = countries;
      selectedCountry = countries.isNotEmpty ? countries[0] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CountrySelector(
                countries: countries, // Pass your list of countries here
                onCountryChanged: (Country country) {
                  setState(() {
                    selectedCountry = country;
                  });
                },
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.h),
                  child: TextFormField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                        labelText: 'Phone number ',
                        prefix: selectedCountry == null
                            ? null
                            : Text(
                                '${selectedCountry!.dialCode} ',
                              ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        counterText: '',
                        border: widget.inputBorder ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                            )),
                    keyboardType: TextInputType.phone,
                    validator: widget.customValidator,
                    onChanged: widget.onInputChanged,
                    maxLength: 9,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                ),
              ),
            ],
          ),
          if (widget.errorMessage != null)
            Container(
              margin: EdgeInsets.only(top: 8.h, left: 90.h),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.errorMessage!,
                style: TextStyle(color: appTheme.inputError, fontSize: 12.0),
                textAlign: TextAlign.left,
              ),
            ),
        ],
      ),
    );
  }
}
