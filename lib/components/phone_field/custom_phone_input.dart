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
  final Function(String)? onCountryCodeChanged;
  InputBorder? inputBorder;
  String? errorMessage;
  TextStyle? labelStyle;
  String? labelText;
  String? outerLabelText;
  bool? autofocus;
  final TextStyle? outerLabelStyle;
  final FormFieldSetter<String>? onSaved;

  CustomPhoneInput({
    super.key,
    required this.controller,
    this.labelText,
    this.outerLabelText,
    this.labelStyle,
    this.autofocus,
    this.customValidator,
    this.onInputChanged,
    this.onCountryCodeChanged,
    this.inputBorder,
    this.errorMessage,
    this.outerLabelStyle,
    this.onSaved,
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
      if (selectedCountry != null) {
        widget.onCountryCodeChanged?.call(selectedCountry!.dialCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.outerLabelText != null)
            SizedBox(
              height: 8.v,
            ),
          if (widget.outerLabelText != null)
            Text(
              widget.outerLabelText!,
              style: widget.outerLabelStyle ?? AppTextStyles.labelStyle,
            ),
          if (widget.outerLabelText != null)
            SizedBox(
              height: 8.v,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CountrySelector(
                countries: countries, // Pass your list of countries here
                onCountryChanged: (Country country) {
                  setState(() {
                    selectedCountry = country;
                    widget.onCountryCodeChanged?.call(selectedCountry!.dialCode);

                    // Update the controller with the new country code
                    String currentText = widget.controller.text;

                    // Remove the previous country code if it exists
                    if (selectedCountry != null) {
                      for (var country in countries) {
                        if (currentText.startsWith(country.dialCode)) {
                          currentText = currentText.substring(country.dialCode.length);
                          break;
                        }
                      }
                    }

                    widget.controller.text = '${selectedCountry!.dialCode}$currentText';
                    widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.controller.text.length),
                    );
                  });
                },
                selectedCountry: selectedCountry!,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 16.h),
                  child: TextFormField(
                    controller: widget.controller,
                    autofocus: widget.autofocus ?? false,
                    decoration: InputDecoration(
                        labelText: widget.labelText ?? 'Phone number ',
                        labelStyle: widget.labelStyle ??
                            TextStyle(
                              color: appTheme.disabledColor,
                            ),
                        // prefix: selectedCountry == null
                        //     ? null
                        //     : Text(
                        //         '${selectedCountry!.dialCode} ',
                        //       ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        counterText: '',
                        border: widget.inputBorder ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                            )),
                    keyboardType: TextInputType.phone,
                    validator: widget.customValidator,
                    onChanged: (value) {
                      if (selectedCountry != null && !value.startsWith(selectedCountry!.dialCode)) {
                        value = '${selectedCountry!.dialCode}$value';
                        widget.controller.text = value;
                        widget.controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: widget.controller.text.length),
                        );
                      }
                      widget.onInputChanged?.call(value);
                    },
                    onSaved: widget.onSaved,
                    // onSaved: (value) {
                    //   if (selectedCountry != null && !value!.startsWith(selectedCountry!.dialCode)) {
                    //     value = '${selectedCountry!.dialCode}$value';
                    //     widget.controller.text = value;
                    //     widget.controller.selection = TextSelection.fromPosition(
                    //       TextPosition(offset: widget.controller.text.length),
                    //     );
                    //   }
                    //   widget.onInputChanged?.call(value!);
                    // },
                    maxLength: 13,
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
