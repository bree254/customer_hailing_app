import 'package:customer_hailing/components/phone_field/custom_phone_input.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class GoogleSignInUpScreen extends StatefulWidget {
  const GoogleSignInUpScreen({super.key});

  @override
  State<GoogleSignInUpScreen> createState() => _GoogleSignInUpScreenState();
}

class _GoogleSignInUpScreenState extends State<GoogleSignInUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? errorMessage;
  InputBorder? inputBorder;

  @override
  void initState() {
    super.initState();
    firstNameController.text = Get.arguments["firstname"];
    lastNameController.text = Get.arguments["lastname"];

    firstNameController.addListener(() => _updateState());
    lastNameController.addListener(() => _updateState());
  }

  void _updateState() {
    setState(() {});
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.verification,
          arguments: {'phone_email': Get.arguments['email'], "verification_type": "email"});
    }
  }

  @override
  void dispose() {
    firstNameController.removeListener(() => _updateState());
    lastNameController.removeListener(() => _updateState());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
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
                controller: firstNameController,
                filled: true,
                fillColor: countryTextFieldColor,
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: "Ariana",
                hintStyle: AppTextStyles.text14Black500,
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
                controller: lastNameController,
                filled: true,
                fillColor: countryTextFieldColor,
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: "Grandeur",
                hintStyle:AppTextStyles.text14Black500,
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
                controller: phoneController,
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
              CustomElevatedButton(
                onPressed: () {
                  onSubmit();
                },
                text: 'Confirm',
                buttonTextStyle: AppTextStyles.titleMedium.copyWith(color: whiteTextColor),
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
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

