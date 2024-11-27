import 'dart:async';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/auth/email/details_email_sign_up_screen.dart';
import 'package:customer_hailing/presentation/auth/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:customer_hailing/presentation/auth/controller/auth_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  String? verificationType;
  String? phoneEmail;
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
    phoneEmail = Get.arguments['phone_email'];
    verificationType = Get.arguments['verification_type'];
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

  void _verifyCode(String pin) async {
    setState(() {
      _isLoading = true;
      _showInvalidCode = false;
    });

    _authController.usernameController.text = phoneEmail!;
    _authController.otpController.text = pin;
    await _authController.validateOtp();

    setState(() {
      _isLoading = false;
      _showInvalidCode = !_authController.isOtpValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Verify your $verificationType",
                style: AppTextStyles.onBoardingAppBarText,
              ),
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please enter the OTP sent to",
                  style: AppTextStyles.text14Black400,
                ),
                Text(
                  phoneEmail!,
                  style: AppTextStyles.text14Black600,
                ),
              ],
            ),
            const SizedBox(height: 32),
            PinCodeTextField(
              appContext: context,
              length: 6,
              animationType: AnimationType.none,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textStyle: AppTextStyles.text14Black400,
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
                if (value.length == 6 && !_isLoading) {
                  _verifyCode(value);
                }
              },
            ),
            const SizedBox(height: 8),
            if (_hasStartedInputting && !_showResendCode)
              Text(
                _resendCodeText,
                style: AppTextStyles.text14Resend400,
              ),
            const SizedBox(height: 16),
            if (_isLoading) ...[
              const CircularProgressIndicator(),
            ] else if (_showInvalidCode) ...[
              Text(
                "Invalid OTP",
                style: AppTextStyles.text14Error400.copyWith(fontSize: 12.0),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _authController.resendOtp();
                },
                child: Text(
                  "Resend code",
                  style: AppTextStyles.text14Resend400.copyWith(
                    decoration: TextDecoration.underline,
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