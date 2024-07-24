import 'package:customer_hailing/components/phone_field/custom_phone_input.dart';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/auth/google/google_sign_in_up_screen.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn();


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

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GoogleSignInUpScreen(),
          ),
        );
        // The user successfully signed in, you can now access their info
        print('Google User: ${googleUser.displayName}');
        // Handle your logic after successful sign-in
      }
    } catch (error) {
      print('Google Sign-In error: $error');
      // Handle the error accordingly
    }
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
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
              padding: const EdgeInsets.only(top: 40.0),
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
                   _handleGoogleSignIn();
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
