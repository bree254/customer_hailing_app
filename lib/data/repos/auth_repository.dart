import 'package:customer_hailing/data/models/auth/auth_response.dart';
import 'package:customer_hailing/data/models/auth/user_response.dart';
import 'package:customer_hailing/data/models/auth/validate_otp.dart';

import '../api/api_client.dart';

class AuthRepository {
  final _apiClient = ApiClient();


  Future<AuthResponse> emailLogin(
      {Map<String, String> headers = const {}, Map requestData = const {}}) async {
    return await _apiClient.login(headers: headers, requestData: requestData);
  }

  Future<ValidOtpResponse> validateOtp(
      {Map<String, String> headers = const {}, Map requestData = const {}}) async {
    return await _apiClient.validateOtp(headers: headers, requestData: requestData);
  }

  Future<AuthResponse> resendotp(
      {Map<String, String> headers = const {}, Map requestData = const {}}) async {
    return await _apiClient.resendOtp(headers: headers, requestData: requestData);
  }

  Future<AuthResponse> updateUser(
      {Map<String, String> headers = const {}, Map requestData = const {}}) async {
    return await _apiClient.updateUser(headers: headers, requestData: requestData);
  }

  Future<UserResponse> getUser(
      {
        Map<String, String> headers = const {},
        required String userName}) async {
    return _apiClient.getUser(
         headers: headers, userName: userName,);
  }
}