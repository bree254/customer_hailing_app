import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:country_picker/country_picker.dart';

class LoginOrSignupScreen extends StatefulWidget {
  const LoginOrSignupScreen({super.key});

  @override
  State<LoginOrSignupScreen> createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {

  final _formKey = GlobalKey<FormFieldState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,84,8,16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                  "Login or Signup",
                style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'br_omny_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Form(
                key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your mobile number",
                        style: TextStyle(
                          color: blackTextColor,
                          fontFamily: 'br_omny_regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20,),
                         Row(
                          children: [
                           Expanded(
                                child: IntlPhoneField(
                                    dropdownIconPosition: IconPosition.trailing,
                                    showCursor: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: countryTextFieldColor, // Gray background color
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), // Circular border
                                        borderSide: BorderSide.none, // No border side
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                    ),
                                    initialCountryCode: 'KE',
                                ),
                              ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: CustomTextFormField(
                                width: 245,
                                controller: _phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your mobile number';
                                  }
                                  return null;
                                },


                              ),
                            ),
                          ],
                        ),

                    ],
                  )),
            )


          ],
        ),
      ),

    );
  }
}
