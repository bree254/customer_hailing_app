import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/auth/validate_otp.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/api/endpoints.dart';
import '../../../data/models/auth/auth_response.dart';
import '../../../data/models/auth/user_response.dart';
import '../../../data/repos/auth_repository.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();

  var user = UserResponse().obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _isOtpValid = false;
  bool get isOtpValid => _isOtpValid;

  String? accessToken;
  //String? userName;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    accessToken = await PrefUtils().retrieveToken('access_token');

    // Get the username from SharedPreferences
    usernameController.text = await PrefUtils().retrieveUsername() ?? '';
    fetchUser(usernameController.text.trim());

    //userName = await PrefUtils().retrieveUsername() ?? '';

    // fetchUser(usernameController.text.trim());
    // //fetchUser('userName');
  }

  Future<void> signIn() async {
    try {
      EasyLoading.show(status: 'Loading...');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> requestData = {
        'username': usernameController.text.trim(),
      };

      AuthResponse response = await authRepository.emailLogin(
        headers: headers,
        requestData: requestData,
      );

      // Handle the response as needed
      if (response.message == 'Success') {

        // Save the username in PrefUtils
        await PrefUtils().saveUsername(usernameController.text.trim());

        Get.offAllNamed(AppRoutes.verification, arguments: {
          'phone_email': usernameController.text,
          "verification_type": "email"
        });
      } else {
        // Show error message
        Get.snackbar('Error', response.message ?? 'Unknown error');
      }
    } catch (e) {
      // Handle any errors
      Get.snackbar('Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }


  Future<void> validateOtp() async {
    EasyLoading.show(status: 'loading...');
    var requestData = {
      'username': usernameController.text.trim(),
      'otp': otpController.text.trim()
    };

    try {
      print('Request data: $requestData');
      ValidOtpResponse response = await authRepository.validateOtp(
          requestData: requestData);

      print('Response data: ${response.toJson()}');

      if (response.authenticationResult != null) {
        final data = response.authenticationResult!;
        final accessToken = data.accessToken;
        final refreshToken = data.refreshToken;

        // Store tokens in SharedPreferences
        await PrefUtils().storeToken('access_token', accessToken!);
        await PrefUtils().storeToken('refresh_token', refreshToken!);

        _isOtpValid = true;
        // Navigate to the next screen
        Get.offAllNamed(AppRoutes.enterYourDetails, arguments: {
          'phone_email': usernameController.text,
          "verification_type": "email"
        });
        showToast('validation success');
      } else {
        _isOtpValid = false;
        EasyLoading.dismiss();
        Get.snackbar('Error', "validation failed");
       // EasyLoading.showError("validation failed",);
      }
    } catch (e) {
      if (e is DioException) {
        print('Request data: $requestData');
        print('Response data: ${e.response?.data}');
      }
      _isOtpValid = false;
      EasyLoading.dismiss();
      Get.snackbar('Error', e.toString());
     // EasyLoading.showError("validation failed",);
    }finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> resendOtp() async {
    try {
      EasyLoading.show(status: 'Loading...');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> requestData = {
        'username': usernameController.text.trim(),
      };

      AuthResponse response = await authRepository.resendotp(
        headers: headers,
        requestData: requestData,
      );

      // Handle the response as needed
      if (response.message == 'Success') {
        Get.snackbar('Success', 'OTP sent successfully');
      } else {
        // Show error message
        Get.snackbar('Error', response.message ?? 'Unknown error');
      }
    } catch (e) {
      // Handle any errors
      Get.snackbar('Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updateUser() async {
    try {
      EasyLoading.show(status: 'Loading...');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',

      };
      Map<String, dynamic> requestData = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastnameController.text.trim(),
        'email': usernameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
      };

      AuthResponse response = await authRepository.updateUser(
        headers: headers,
        requestData: requestData,
      );

      // Handle the response as needed
      if (response.message == 'User updated successfully.') {
        print('Navigation to privacy policy screen');
        Get.offAllNamed(AppRoutes.privacyPolicy);
        Get.snackbar('Success', 'User updated successfully');
      } else {
        // Show error message
        Get.snackbar('Error', response.message ?? 'Unknown error');
      }
    } catch (e) {
      // Handle any errors
      Get.snackbar('Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updateUserProfile(String firstName, String lastName, String email, String phoneNumber) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
      };

      // Log the request URL and parameters
      print('Updating user with details: $requestData');
      print('Request URL: ${Endpoints.updateUser}');
      print('Headers: $headers');

      await authRepository.updateUser(
        headers: headers,
        requestData: requestData,
      );

      // Update the local user value
      user.value.firstName = firstName;
      user.value.lastName = lastName;
      user.value.email = email;
      user.value.phoneNumber = phoneNumber;

      // Handle the user response as needed
      print('User updated successfully');
    } catch (e) {
      // Handle any errors
      print('Error updating user: $e');
    }
  }

Future<void> logout()async {
    try{
// Access shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Remove the access and refresh tokens
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');

      // Clear other user-related data if necessary
      await prefs.clear(); // Optional: Clears all data stored in shared preferences

      // Navigate to the login screen
      Get.offAllNamed(AppRoutes.loginorsignup);
    }catch(e){
      Get.snackbar('Error', 'Error during logout: $e');
    }
}
  Future<void> fetchUser(String userName) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Fetching user with username: $userName');
      print('Request URL: ${Endpoints.getUser}$userName');
      print('Headers: $headers');

      UserResponse userResponse = await authRepository.getUser(
        headers: headers,
        userName: userName,
      );

      user.value = userResponse;

      // Handle the user response as needed
      print('User fetched successfully: ${userResponse.toJson()}');
    } catch (e) {
      // Handle any errors
      print('Error fetching user: $e');
    }
  }


  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.7),
      // Semi-transparent background
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}
