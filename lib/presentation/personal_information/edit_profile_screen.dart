import 'dart:convert';

import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import '../../components/phone_field/custom_phone_input.dart';
import '../../core/constants/constants.dart';
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

  final ImagePicker picker = ImagePicker();
  Map<String, XFile?> images = {};
  Map<String, double> uploadProgress = {};
  Map<String, String> uploadStatus = {};
  String? imageUrl;

  @override
  void initState() {
    super.initState();

    firstNameController.text = authController.user.value.firstName!;
    lastNameController.text = authController.user.value.lastName!;
    emailController.text = authController.user.value.email!;
    phoneController.text = authController.user.value.phoneNumber!;
    imageUrl = authController.user.value.profileUrl != null
        ? '${authController.user.value.profileUrl}'
        : null;

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
      authController.updateUserProfile(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        imageUrl ?? '',
        phoneController.text,
      );
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

  Future<void> uploadPhoto(String section) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          images[section] = image;
          uploadProgress[section] = 0.0;
          uploadStatus[section] = 'Uploading...';
        });

        String driverName = await PrefUtils().getUserData()?.firstName ?? 'default_folder';
        String? mimeType = lookupMimeType(image.path);
        String? fileExtension = image.name.split('.').last;
        String fileBase64 = base64Encode(await image.readAsBytes());

        await authController.getUploadUrl(
          folderName: driverName,
          contentType: mimeType!,
          fileExtension: fileExtension,
          fileName: image.name,
          fileBase64: fileBase64,
          navigateBack: false,
        );

        if (authController.uploadUrl.value.isNotEmpty) {
          setState(() {
            uploadProgress[section] = 1.0;
            uploadStatus[section] = 'Upload complete';
            imageUrl = '$imageBaseUrl${authController.uploadUrl.value}';
          });
        } else {
          setState(() {
            uploadStatus[section] = 'Failed to get URL';
          });
        }

      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> takePhoto(String section) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          images[section] = image;
          uploadProgress[section] = 0.0;
          uploadStatus[section] = 'Uploading...';
        });

        String driverName = await PrefUtils().getUserData()?.firstName ?? 'default_folder';
        String? mimeType = lookupMimeType(image.path);
        String? fileExtension = image.name.split('.').last;
        String fileBase64 = base64Encode(await image.readAsBytes());

        await authController.getUploadUrl(
          folderName: driverName,
          contentType: mimeType!,
          fileExtension: fileExtension,
          fileName: image.name,
          fileBase64: fileBase64,
          navigateBack: false,
        );
        if (authController.uploadUrl.value.isNotEmpty) {
          setState(() {
            uploadProgress[section] = 1.0;
            uploadStatus[section] = 'Upload complete';
            imageUrl = '$imageBaseUrl${authController.uploadUrl.value}';
          });
        } else {
          setState(() {
            uploadStatus[section] = 'Failed to get URL';
          });
        }
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
    }
  }

  void _showPhotoOptions(String section) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Upload from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  uploadPhoto(section);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  takePhoto(section);
                },
              ),
            ],
          ),
        );
      },
    );
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
                        radius: 80,
                        backgroundColor: primaryColor,
                        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                        child: imageUrl == null
                            ? Text(
                          initials,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : null,
                      ),
                ),
                    Positioned(
                      top: 44,
                      left: 48,
                      right: 1,
                      child:
                      GestureDetector(
                          onTap: () => _showPhotoOptions('profile'),
                          child: Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                              child: const Icon(Icons.camera_alt_outlined,color: searchtextGrey,size: 18,))
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
                        readOnly: false,
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
                        readOnly: false,
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
                        readOnly: false,
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
                          authController.updateUserProfile(
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            imageUrl ?? '',
                            phoneController.text,
                          );
                          Get.back(result: true);
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
