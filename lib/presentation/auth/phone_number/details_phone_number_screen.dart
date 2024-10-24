import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../components/phone_field/custom_phone_input.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_text_form_field.dart';
class DetailsPhoneNumberScreen extends StatefulWidget {
  const DetailsPhoneNumberScreen({super.key});

  @override
  State<DetailsPhoneNumberScreen> createState() => _DetailsPhoneNumberScreenState();
}

class _DetailsPhoneNumberScreenState extends State<DetailsPhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? errorMessage;
  InputBorder? inputBorder;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    firstNameController.addListener(() => _updateButtonState());
    lastNameController.addListener(() => _updateButtonState());
    emailController.addListener(() => _updateButtonState());
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = firstNameController.text.isNotEmpty;
      _isButtonEnabled = lastNameController.text.isNotEmpty;
      _isButtonEnabled = emailController.text.isNotEmpty;

    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.verification,
          arguments: {
        'phone_email': Get.arguments['phone_email'],
         "verification_type": "email"
      });
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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Enter your details",
                  style: TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 40.v),
              const Text(
                "First name",
                style: TextStyle(
                  color: formTextLabelColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
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
                hintStyle: const TextStyle(
                  color: blackTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
              const Text(
                "Last name",
                style: TextStyle(
                  color: formTextLabelColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
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
                hintStyle: const TextStyle(
                  color: blackTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Last name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
            const Text(
              "Enter your email",
              style: TextStyle(
                color: formTextLabelColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: emailController,
              filled: true,
              fillColor: countryTextFieldColor,
              labelText: "name@email.com",
              labelStyle: const TextStyle(
                color: blackTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              autofocus: false,
              // height: 96.h,
              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
              const Spacer(),
              CustomElevatedButton(
                onPressed: () {
                  onSubmit();
                },
                text: 'Continue',
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
