
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginOrSignupScreen extends StatefulWidget {
  const LoginOrSignupScreen({super.key});

  @override
  State<LoginOrSignupScreen> createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {
  final _formKey = GlobalKey<FormFieldState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _phoneController.text.isNotEmpty;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Add your logic to check if the number exists
      bool numberExists = false; // Replace this with actual check

      if (numberExists) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('This number already exists.')),
        // );
      } else {

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 84, 16, 0),
        child: Column(
          children: [
            const Align(
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
                      const Text(
                        "Enter your mobile number",
                        style: TextStyle(
                          color: blackTextColor,
                          fontFamily: 'br_omny_regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: SizedBox(
                                height: 60,
                                child: IntlPhoneField(
                                  dropdownIconPosition: IconPosition.trailing,
                                  showCursor: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: countryTextFieldColor,
                                    counterText: " ",
                                    // Gray background color
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // Circular border
                                      borderSide:
                                          BorderSide.none, // No border side
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                  ),
                                  initialCountryCode: 'KE',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: CustomTextFormField(
                                width: 245,
                                controller: _phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your mobile number';
                                  } else if (value.length < 10) {
                                    return "incomplete number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButton(
                        text: 'Continue',
                        onPressed: (){
                          Get.offNamed(AppRoutes.verification);
                        },
                        buttonTextStyle: const TextStyle(
                          color: whiteTextColor,
                          fontFamily: 'br_omny_regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? primaryColor
                              : disabledButtonGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
                "or",
              style:TextStyle(
                color: formTextLabelColor,
                fontFamily: 'br_omny_regular',
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Column(
              children: [
                CustomElevatedButton(
                  text: 'Continue with Google',
                  leftIcon: SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: Image.asset('assets/images/google.png'),
                  ),
                  buttonTextStyle: const TextStyle(
                    color: blackTextColor,
                    fontFamily: 'br_omny_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor:buttonGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomElevatedButton(
                  text: 'Continue with email',
                  leftIcon:SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: Image.asset('assets/images/mail.png'),
                  ),
                  buttonTextStyle: const TextStyle(
                    color: blackTextColor,
                    fontFamily: 'br_omny_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor:buttonGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
