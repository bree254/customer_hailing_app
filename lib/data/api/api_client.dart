import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/api_response.dart';
import 'package:customer_hailing/data/models/auth/auth_response.dart';
import 'package:customer_hailing/data/models/auth/update_profile_response.dart';
import 'package:customer_hailing/data/models/auth/user_response.dart';
import 'package:customer_hailing/data/models/auth/validate_otp.dart';
import 'package:customer_hailing/data/models/ride_requests/confirm_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/driver_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/rate_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/scheduled_trip_details_response.dart';
import 'package:customer_hailing/data/models/ride_requests/scheduled_trips_response.dart';
import 'package:customer_hailing/data/models/ride_requests/search_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/share_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_details_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_history_response.dart';
import 'package:customer_hailing/presentation/order_request/screens/search_location_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import '../../core/utils/logger.dart';
import '../models/auth/upload_file.dart';
import '../models/ride_requests/schedule_trip_response.dart';
import '../models/ride_requests/trip_history_details_response.dart';
import 'endpoints.dart';
import 'network_interceptor.dart';

class ApiClient extends GetConnect {
  var uri = Endpoints.baseUrl;

  final _dio = dio.Dio(dio.BaseOptions(connectTimeout: const Duration(seconds: 3)));

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

  Future<SearchLocationsResponse> uploadLocation(
      {required Map<String, String> headers, required Map requestData}) async {
    isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.postLocation,
          data: requestData, options: dio.Options(headers: headers));
      if (_isSuccessCall(response)) {
        return SearchLocationsResponse.fromJson(response.data);
      } else {
        debugPrint('Response :: ${response.statusCode}');
        return SearchLocationsResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ConfirmTripResponse> confirmTrip(
      {required Map<String, String> headers, required Map requestData}) async {
    isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.confirmTrip,
          data: requestData, options: dio.Options(headers: headers));
      if (_isSuccessCall(response)) {
        return ConfirmTripResponse.fromJson(response.data);
      } else {
        debugPrint('Response :: ${response.statusCode}');
        return ConfirmTripResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<TripDetailsResponse> getTripDetails(
      {required Map<String, String> headers,required String requestId}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.get('${Endpoints.tripDetails}$requestId',
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return TripDetailsResponse.fromJson(response.data);
      } else {
        return TripDetailsResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<TripHistoryResponse> tripHistory(
      {required Map<String, String> headers,required String customerId}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.get('${Endpoints.tripHistory}$customerId/completedTrips',
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return TripHistoryResponse.fromJson(response.data);
      } else {
        return TripHistoryResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<TripHistoryDetailsResponse> tripHistoryDetails(
      {required Map<String, String> headers,required String tripId}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.get('${Endpoints.historyDetails}$tripId/completedTripDetails',
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return TripHistoryDetailsResponse.fromJson(response.data);
      } else {
        return TripHistoryDetailsResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }


  Future<RateTripResponse> rateTrip(
      {required Map<String, String> headers, required Map requestData}) async {
    isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.rateTrip,
          data: requestData, options: dio.Options(headers: headers));
      if (_isSuccessCall(response)) {
        return RateTripResponse.fromJson(response.data);
      } else {
        debugPrint('Response :: ${response.statusCode}');
        return RateTripResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ScheduleTripResponse> scheduleTrip(
      {required Map<String, String> headers, required Map requestData}) async {
    isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.scheduleTrip,
          data: requestData, options: dio.Options(headers: headers));


      if (_isSuccessCall(response)) {
        return ScheduleTripResponse.fromJson(response.data);
      } else {
        debugPrint('Response :: ${response.statusCode}');
        return ScheduleTripResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<DriverLocationsResponse>> getDriverLocations({required Map<String, String> headers}) async {
  final response = await _dio.get(
  Endpoints.driverLocations,
  options: dio.Options(headers: headers),
  );

  if (response.statusCode == 200) {
  List<dynamic> data = response.data;
  return data.map((json) => DriverLocationsResponse.fromJson(json)).toList();
  } else {
  throw Exception('Failed to load driver locations');
  }
  }

  Future<UploadFileResponse> uploadProfile({
    required Map<String, String> headers,
    required Map<String, dynamic> requestData,
  }) async {
    await isNetworkConnected();

    try {
      var response = await _dio.post(
        Endpoints.uploadProfile,
        data: requestData,
        options: dio.Options(headers: headers),
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          //debugPrint('Progress: $progress');
        },
      );
      if (_isSuccessCall(response)) {
        return UploadFileResponse.fromJson(response.data);
      } else {
        return UploadFileResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<UpdateProfileResponse> updateProfile({
    required Map<String, String> headers,
    required Map<String, dynamic> requestData,
  }) async {
    await isNetworkConnected();

    try {
      var response = await _dio.patch(
        Endpoints.updateProfile,
        data: requestData,
        options: dio.Options(headers: headers),
      );
      if (_isSuccessCall(response)) {
        return UpdateProfileResponse.fromJson(response.data);
      } else {
        return UpdateProfileResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<ScheduledTripsResponse>> scheduledTrips({
    required Map<String, String> headers,
    required String customerId,
  }) async {
    await isNetworkConnected();

    try {
      var response = await _dio.get('${Endpoints.scheduledTrip}$customerId',
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        List<dynamic> data = response.data;
        return data.map((json) => ScheduledTripsResponse.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ScheduledTripDetailsResponse> scheduledTripDetails(
      {required Map<String, String> headers,required String tripId}) async {
    await isNetworkConnected();

    try {
      var response = await _dio.get('${Endpoints.scheduledTripDetails}$tripId',
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return ScheduledTripDetailsResponse.fromJson(response.data);
      } else {
        return ScheduledTripDetailsResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ShareTripResponse> shareTrip({
    required Map<String, String> headers,
    required String tripId,
  }) async {
    await isNetworkConnected();

    final url = '${Endpoints.shareTrip}?tripId=$tripId';

    try {
      var response = await _dio.post(
        url,
        options: dio.Options(headers: headers),
      );
      debugPrint('Share trip #####Request URL: ${response.requestOptions.uri}');
      debugPrint('Share trip  #####Response status: ${response.statusCode}');
      debugPrint('Share trip  #####Response data: ${response.data}');
      if (_isSuccessCall(response)) {
        return ShareTripResponse.fromJson(response.data);
      } else {
        return ShareTripResponse.fromJson(response.data);
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ApiResponse> raiseSos(
      {required Map<String, String> headers, required Map requestData}) async {
    isNetworkConnected();

    try {
      var response = await _dio.post(Endpoints.raiseSos,
          data: requestData, options: dio.Options(headers: headers));

      debugPrint('Raise SOS #####Request URL: ${response.requestOptions.uri}');
      debugPrint('Raise SOS  #####Response status: ${response.statusCode}');
      debugPrint('Raise SOS  #####Response data: ${response.data}');


      if (_isSuccessCall(response)) {
        return ApiResponse.fromJson(response.data);
      } else {
        debugPrint('Response :: ${response.statusCode}');
        return ApiResponse.fromJson(response.data);
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
