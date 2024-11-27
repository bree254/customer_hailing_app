import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../components/phone_field/custom_phone_input.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_text_form_field.dart';

class EnterYourDetailsScreen extends StatefulWidget {
  const EnterYourDetailsScreen({super.key});

  @override
  State<EnterYourDetailsScreen> createState() => _EnterYourDetailsScreenState();
}

class _EnterYourDetailsScreenState extends State<EnterYourDetailsScreen> {

  final AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  String? verificationType;
  String? phoneEmail;
  String? errorMessage;
  InputBorder? inputBorder;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    phoneEmail = Get.arguments['phone_email'];
    verificationType = Get.arguments['verification_type'];

    authController.firstNameController.addListener(() => _updateButtonState());
    authController.lastnameController.addListener(() => _updateButtonState());
    authController.emailController.addListener(() => _updateButtonState());
    authController.phoneController.addListener(() => _updateButtonState());
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = authController.firstNameController.text.isNotEmpty;
      _isButtonEnabled = authController.lastnameController.text.isNotEmpty;
      _isButtonEnabled = authController.emailController.text.isNotEmpty;
      _isButtonEnabled = authController.phoneController.text.isNotEmpty;

    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      authController.usernameController.text = phoneEmail!;
      authController.updateUser();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.h, 32.v, 16.h, 16.v),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.v),
               Align(
                alignment: Alignment.center,
                child: Text(
                  "Enter your details",
                  style: AppTextStyles.onBoardingAppBarText,
                ),
              ),
              SizedBox(height: 40.v),
               Text(
                "First name",
                style: AppTextStyles.text14Black400,
              ),
              SizedBox(height: 10.v),
              CustomTextFormField(
                controller: authController.firstNameController,
                filled: true,
                fillColor: countryTextFieldColor,
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: "Ariana",
                hintStyle:  AppTextStyles.text14Black500,
                contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
               Text(
                "Last name",
                style: AppTextStyles.text14Black400,
              ),
              SizedBox(height: 10.v),
              CustomTextFormField(
                controller: authController.lastnameController,
                filled: true,
                fillColor: countryTextFieldColor,
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: "Grandeur",
                hintStyle:  AppTextStyles.text14Black500,
                contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Last name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
               Text(
                "Enter your mobile number",
                style: AppTextStyles.text14Black400,
              ),
              SizedBox(height: 10.v),
              CustomPhoneInput(
                controller: authController.phoneController,
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
                customValidator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.zero,
                child: CustomElevatedButton(
                  text: 'Next',
                  onPressed: _isButtonEnabled
                      ? () {
                    onSubmit();
                  }
                      : null,
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isButtonEnabled ? primaryColor : disabledButtonGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Center(
                  child: Text(
                    "Back",
                    style: AppTextStyles.backButtonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
