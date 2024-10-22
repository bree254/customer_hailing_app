import 'dart:async';

import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/password_and_security_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class TwoFactorAuthenticationScreen extends StatefulWidget {
  const TwoFactorAuthenticationScreen({super.key});

  @override
  State<TwoFactorAuthenticationScreen> createState() => _TwoFactorAuthenticationScreenState();
}

class _TwoFactorAuthenticationScreenState extends State<TwoFactorAuthenticationScreen> {
  final TextEditingController _pinController = TextEditingController();

  String? verificationType;
  String? phoneEmail;
  String? email;
  bool _showResendCode = false;
  bool _showInvalidCode = false;
  bool _isLoading = false;
  bool _hasStartedInputting = false;
  String _resendCodeText = "Resend code in 30 seconds";
  Timer? _timer;
  int _resendTimerSeconds = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimerSeconds = 30; // Reset timer to 30 seconds
    setState(() {
      _resendCodeText = "Resend code in $_resendTimerSeconds seconds";
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendTimerSeconds--;
        if (_resendTimerSeconds > 0) {
          _resendCodeText = "Resend code in $_resendTimerSeconds seconds";
        } else {
          _timer?.cancel();
          if (_hasStartedInputting) {
            _showResendCode = true;
            _resendCodeText = "Resend code";
          }
        }
      });
    });
  }

  void _verifyCode(String pin) {
    setState(() {
      _isLoading = true;
      _showInvalidCode = false;
    });

    // Simulate a network request for code verification
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        if (pin == "1234") {
          // Replace with your actual verification logic
          // Code is correct
          _showInvalidCode = false;
          //navigate to the privacy policy screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PasswordAndSecurityScreen()),
          );
        } else {
          // Code is incorrect
          _showInvalidCode = true;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '2 Factor Authentication',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            // const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Please enter the OTP sent to",
                  style: TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "0759633729",
                  style: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            PinCodeTextField(
              appContext: context,
              length: 4,
              animationType: AnimationType.none,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 44,
                fieldWidth: 44,
                borderWidth: 1,
                activeBorderWidth: 1,
                inactiveBorderWidth: 1,
                errorBorderWidth: 1,
                selectedBorderWidth: 1,
                activeColor: _showInvalidCode ? textfieldErrorRedColor : primaryColor,
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
                if (value.isNotEmpty && !_hasStartedInputting) {
                  setState(() {
                    _hasStartedInputting = true;
                  });
                  _startResendTimer();
                }
                if (value.length == 4 && !_isLoading) {
                  _verifyCode(value);
                }
              },
            ),
            const SizedBox(height: 8),
            if (_hasStartedInputting && !_showResendCode)
              Text(_resendCodeText,
                  style: const TextStyle(
                    color: resendCodeTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  )),
            const SizedBox(height: 16),
            if (_isLoading) ...[
              const CircularProgressIndicator(),
            ] else if (_showInvalidCode) ...[
              const Text(
                "Invalid OTP",
                style: TextStyle(
                  color: textfieldErrorRedColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Handle resend code action
                },
                child: const Text(
                  "Resend code",
                  style: TextStyle(
                    color: resendCodeTextColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
