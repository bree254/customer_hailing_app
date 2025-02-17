import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../components/phone_field/custom_phone_input.dart';
import '../../widgets/custom_text_form_field.dart';
import '../auth/controller/auth_controller.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? errorMessage;
  InputBorder? inputBorder;

  @override
  void initState() {
    super.initState();

    firstNameController.text = authController.user.value.firstName!;
    lastNameController.text = authController.user.value.lastName!;
    emailController.text = authController.user.value.email!;
    phoneController.text = authController.user.value.phoneNumber!;

    authController.firstNameController.addListener(() => _updateState());
    authController.lastnameController.addListener(() => _updateState());
    authController.emailController.addListener(() => _updateState());
    authController.phoneController.addListener(() => _updateState());
  }

  void _updateState() {
    setState(() {});
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      // authController.updateUserProfile(
      //   firstNameController.text,
      //   lastNameController.text,
      //   emailController.text,
      //   phoneController.text,
      // );
    }
  }

  @override
  void dispose() {
    authController.firstNameController.removeListener(() => _updateState());
    authController.lastnameController.removeListener(() => _updateState());
    authController.usernameController.removeListener(() => _updateState());
    authController.phoneController.removeListener(() => _updateState());
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String initials = '${authController.user.value.firstName?[0]}${authController.user.value.lastName?[0]}';
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
                        // image: const DecorationImage(
                        //   image: AssetImage("assets/images/driver.png"),
                        //   fit: BoxFit.cover,
                        // ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF7145D6),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child:  CircleAvatar(
                        backgroundColor: primaryColor,
                       // radius: 28,
                        child: Text(
                          initials,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
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
                              color: Colors.white
                            ),
                              child: const Icon(Icons.camera_alt_outlined,color: primaryColor,size: 18,))
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
                        readOnly: true,
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
                        readOnly: true,
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
        
                      //  Text(
                      //   "Gender",
                      //   style:AppTextStyles.text14Black400.copyWith(
                      //     color: formTextLabelColor,
                      //   ),
                      // ),
                      // SizedBox(height: 10.v),
                      // CustomTextFormField(
                      //   controller: firstNameController,
                      //   filled: true,
                      //   fillColor: countryTextFieldColor,
                      //   borderDecoration: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide: const BorderSide(color: Colors.transparent, width: 0),
                      //   ),
                      //   hintText: "Female",
                      //   hintStyle: AppTextStyles.text14Black500.copyWith(
                      //   color: blackTextColor,
                      // ),
                      //   contentPadding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 10.h),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter your gender';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(height: 20.v),
        
                       Text(
                        "Email",
                        style:AppTextStyles.text14Black400.copyWith(
                          color: formTextLabelColor,
                        ),
                      ),
                      SizedBox(height: 10.v),
                      CustomTextFormField(
                        controller: emailController,
                        readOnly: true,
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
                        //readOnly: true,
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
