import 'package:customer_hailing/components/phone_field/custom_phone_input.dart';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginOrSignupScreen extends StatefulWidget {
  const LoginOrSignupScreen({super.key});

  @override
  State<LoginOrSignupScreen> createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {
  final _formKey = GlobalKey<FormFieldState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;
  String? errorMessage;
  InputBorder? inputBorder;


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
  void navigateToVerificationScreen() {
    // Assuming the correct length is 9
    if (_phoneController.text.length == 9) {
      Get.toNamed(AppRoutes.verification);
    } else {
      // Update the UI to show an error or change the input border color
      setState(() {
        errorMessage = 'Incomplete number';
        inputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide(color: appTheme.inputError),
        );
      });
    }
  }

  void _showGoogleSignInOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    height: 21.5,
                      width: 21.5,
                      "assets/images/google.png"),
                  Text(
                    'Sign in to Taxi with Google',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              const SizedBox(height: 20.0),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user1.png'),
                ),
                title: const Text('Ariana Grandeur'),
                subtitle: const Text('arianagrandeur@gmail.com'),
                onTap: () {
                  // Handle the account selection
                },
              ),
              Divider(color: resendCodeTextColor,),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user2.png'),
                ),
                title: const Text('Ariana Grandeur'),
                subtitle: const Text('grandeurarianar@gmail.com'),
                onTap: () {
                  // Handle the account selection
                },
              ),
              Divider(color: resendCodeTextColor,),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user3.png'),
                ),
                title: const Text('Ariana Grandeur'),
                subtitle: const Text('ariana_grandeur@gmail.com'),
                onTap: () {
                  // Handle the account selection
                },
              ),
            ],
          ),
        );
      },
    );
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
                      CustomPhoneInput(
                        controller: _phoneController,
                        onInputChanged: (value) {
                          String? newErrorMessage;
                          InputBorder newInputBorder;

                          if (value.length == 9) {
                            newErrorMessage = null;
                            newInputBorder = OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                              borderSide: BorderSide(color: appTheme.colorPrimary),
                            );
                          } else {
                            newErrorMessage = 'Incomplete number';
                            newInputBorder = OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                              borderSide: BorderSide(color: appTheme.inputError),
                            );
                          }
                          setState(() {
                            errorMessage = newErrorMessage;
                            inputBorder = newInputBorder;
                          });
                        },
                        inputBorder: inputBorder,
                        errorMessage: errorMessage,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButton(
                        text: 'Continue',
                        onPressed:  _phoneController.text.isNotEmpty
                            ? () {
                          navigateToVerificationScreen();
                        }
                            : null,
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
                  onPressed: () {
                    _showGoogleSignInOptions(context);
                  },
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
