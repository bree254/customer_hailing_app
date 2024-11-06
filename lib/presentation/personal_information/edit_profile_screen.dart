import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../components/phone_field/custom_phone_input.dart';
import '../../widgets/custom_text_form_field.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? errorMessage;
  InputBorder? inputBorder;

  @override
  void initState() {
    super.initState();

    firstNameController.addListener(() => _updateState());
    lastNameController.addListener(() => _updateState());
  }

  void _updateState() {
    setState(() {});
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'Edit Profile',
          style: AppTextStyles.largeAppBarText,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 76,
                      height: 75,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/driver.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF7145D6),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 44,
                      left: 48,
                      right: 1,
                      child:
                      GestureDetector(
                          child: Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor
                            ),
                              child: const Icon(Icons.camera_alt_outlined,color: Colors.white,size: 18,))
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
               Text(
                'Edit photo',
                textAlign: TextAlign.center,
                style:AppTextStyles.text14Black500.copyWith(
                  color: searchtextGrey,
                ),
              ),
              const SizedBox(height: 32,),
        
              Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "First name",
                        style:AppTextStyles.text14Black400.copyWith(
                          color: formTextLabelColor,
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
                        hintStyle: AppTextStyles.text14Black500.copyWith(
                        color: blackTextColor,
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
                       Text(
                        "Last name",
                        style:AppTextStyles.text14Black400.copyWith(
                          color: formTextLabelColor,
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
                        hintStyle:  AppTextStyles.text14Black500.copyWith(
                        color: blackTextColor,
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
        
                       Text(
                        "Gender",
                        style:AppTextStyles.text14Black400.copyWith(
                          color: formTextLabelColor,
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
                        hintText: "Female",
                        hintStyle: AppTextStyles.text14Black500.copyWith(
                        color: blackTextColor,
                      ),
                        contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your gender';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.v),
        
                       Text(
                        "Email",
                        style:AppTextStyles.text14Black400.copyWith(
                          color: formTextLabelColor,
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
                        hintText: "johndoe@gmail.com",
                        hintStyle: AppTextStyles.text14Black500.copyWith(
                        color: blackTextColor,
                      ),
                        contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.v),
        
                       Text(
                        "Enter your mobile number",
                        style:AppTextStyles.text14Black400.copyWith(
                          color: formTextLabelColor,
                        ),
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
                      const SizedBox(height: 39,),
                      CustomElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        text: 'Save',
                        buttonTextStyle: AppTextStyles.titleMedium.copyWith(color: whiteTextColor),
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
