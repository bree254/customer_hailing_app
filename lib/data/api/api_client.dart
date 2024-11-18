import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/auth/email_sign_up_screen.dart';
import 'package:customer_hailing/presentation/auth/email/email_sign_up_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

import '../../core/utils/logger.dart';
import 'endpoints.dart';
import 'network_interceptor.dart';

class ApiClient extends GetConnect {
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

  Future<EmailSignUpResponse>signUp({required Map<String, String> headers, required Map requestData}) async {
    try {
      final response = await _dio.post(
        '${Endpoints.baseUrlUser}signup',
        data: requestData,
        options: dio.Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return EmailSignUpResponse.fromJson(response.data);
      } else {
        return EmailSignUpResponse.fromJson(response.data);
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
