import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _showResendCode = false;
  bool _showInvalidCode = false;
  bool _isLoading = false;
  String _resendCodeText = "Resend code in 30s";

  @override
  void initState() {
    super.initState();
    // Start a timer to show resend code after 30 seconds
    Future.delayed(Duration(seconds: 30), () {
      setState(() {
        _showResendCode = true;
      });
    });
  }

  void _verifyCode(String pin) {
    setState(() {
      _isLoading = true;
      _showInvalidCode = false;
    });

    // Simulate a network request for code verification
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        if (pin == "1234") { // Replace with your actual verification logic
          // Code is correct
          _showInvalidCode = false;
        } else {
          // Code is incorrect
          _showInvalidCode = true;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 84, 16, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Verify your mobile number",
                style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'br_omny_regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Please enter the OTP sent to 0712345678",
              style: TextStyle(
                color: blackTextColor,
                fontFamily: 'br_omny_regular',
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 32),
            PinCodeTextField(
              appContext: context,
              length: 4,
              animationType: AnimationType.none,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 44,
                fieldWidth: 44,
                activeColor: whiteTextColor,
                inactiveColor: countryTextFieldColor,
                activeFillColor: whiteTextColor,
                inactiveFillColor: countryTextFieldColor,
                selectedFillColor: whiteTextColor,
                errorBorderColor: textfieldErrorRedColor,
                selectedColor: primaryColor,
              ),
              enableActiveFill: true,
              controller: _pinController,
              onChanged: (value) {
                if (value.length == 4 && !_isLoading) {
                  _verifyCode(value);
                }
              },
            ),
            SizedBox(height: 32),
            if (_isLoading) ...[
              CircularProgressIndicator(),
            ] else if (_showInvalidCode) ...[
              Text(
                "Invalid code",
                style: TextStyle(color: textfieldErrorRedColor),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Handle resend code action
                },
                child: Text("Resend code"),
              ),
            ] else if (_showResendCode) ...[
              TextButton(
                onPressed: () {
                  // Handle resend code action
                },
                child: Text("Resend code"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}