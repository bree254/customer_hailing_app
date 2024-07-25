import 'package:customer_hailing/components/phone_field/custom_phone_input.dart';
import 'package:customer_hailing/core/utils/colors.dart';
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
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Enter your details",
                  style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'br_omny_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Form(
                  key:_formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "First name",
                          style: TextStyle(
                            color: formTextLabelColor,
                            fontFamily: 'br_omny_regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: firstNameController,
                          filled: true,
                          fillColor: countryTextFieldColor,
                          borderDecoration: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Ariana",
                          hintStyle: const TextStyle(
                            color: blackTextColor,
                            fontFamily: 'br_omny_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Last name",
                          style: TextStyle(
                            color: formTextLabelColor,
                            fontFamily: 'br_omny_regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: firstNameController,
                          filled: true,
                          fillColor: countryTextFieldColor,
                          borderDecoration: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Grandeur",
                          hintStyle: const TextStyle(
                            color: blackTextColor,
                            fontFamily: 'br_omny_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Enter your mobile number",
                          style: TextStyle(
                            color: formTextLabelColor,
                            fontFamily: 'br_omny_regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
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
                        ),
                        // Spacer(),
                        Padding(
                            padding: EdgeInsets.only(top: 302),
                          child: CustomElevatedButton(
                            text: 'Confirm',
                            buttonTextStyle: const TextStyle(
                              color: whiteTextColor,
                              fontFamily: 'br_omny_regular',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),

                          ),
                        )
                      ],
                )),
            ],
          ),
        ),
    );
  }
}
