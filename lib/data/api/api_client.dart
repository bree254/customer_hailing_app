import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/auth/auth_response.dart';
import 'package:customer_hailing/data/models/auth/user_response.dart';
import 'package:customer_hailing/data/models/auth/validate_otp.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import '../../core/utils/logger.dart';
import 'endpoints.dart';
import 'network_interceptor.dart';

class ApiClient extends GetConnect {
  var uri = Endpoints.baseUrl;

  final _dio = dio.Dio(dio.BaseOptions(connectTimeout: const Duration(seconds: 3), baseUrl: ''));

  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _dio.interceptors.add(dio.LogInterceptor());
    _dio.interceptors.add(NetworkInterceptor());

    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        Get.dialog(
          AlertDialog(
            title: Text(
              'Network Error',
              style: TextStyle(color: appTheme.error),
            ),
            content: const Text('Please ensure your internet connection is stable.'),
            backgroundColor: Theme.of(Get.context!).brightness == Brightness.light
                ? appTheme.white
                : appTheme.white,
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: appTheme.colorPrimary,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  "Ok",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16.0,
                    color: appTheme.colorPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
  Future isNetworkConnected() async {
    if (!await Get.find<NetworkInfo>().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  bool _isSuccessCall(dio.Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    }
    return false;
  }
  Future<AuthResponse> login(
      {required Map<String, String> headers, required Map requestData}) async {
    isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.loginUser,
          data: requestData, options: dio.Options(headers: headers));
      if (_isSuccessCall(response)) {
        return AuthResponse.fromJson(response.data);
      } else {
        debugPrint('Response :: ${response.statusCode}');
        return AuthResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ValidOtpResponse> validateOtp(
      {required Map<String, String> headers, required Map requestData}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.validateOtp,
          data: requestData, options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return ValidOtpResponse.fromJson(response.data);
      } else {
        return ValidOtpResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<AuthResponse> resendOtp(
      {required Map<String, String> headers, required Map requestData}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.resendOtp,
          data: requestData, options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return AuthResponse.fromJson(response.data);
      } else {
        return AuthResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<AuthResponse> updateUser(
      {required Map<String, String> headers, required Map requestData}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.updateUser,
          data: requestData, options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return AuthResponse.fromJson(response.data);
      } else {
        return AuthResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<UserResponse> getUser(
      {required Map<String, String> headers,required String userName}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.get('${Endpoints.getUser}$userName',
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return UserResponse.fromJson(response.data);
      } else {
        return UserResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
  Future<Response> postRequest(String url, Map<String, dynamic> body) async {
    return await post(url, body);
  }

  Future<Response> getRequest(String url) async {
    return await get(url);
  }

  Future<Response> putRequest(String url, Map<String, dynamic> body) async {
    return await put(url, body);
  }

  Future<Response> deleteRequest(String url) async {
    return await delete(url);
  }

  Future<Response> patchRequest(String url, Map<String, dynamic> body) async {
    return await patch(url, body);
  }

  Future<Response> uploadFile(String url, String filePath, String fileName) async {
    return await post(url, FormData({'file': MultipartFile(filePath, filename: fileName)}));
  }

  // Future<Response> downloadFile(String url, String filePath) async {
  //   // return await download(url, filePath);
  //   return Response(requestOptions: RequestOptions(path: ''));
  // }
}
