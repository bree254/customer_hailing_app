import 'package:dio/dio.dart';

/// NetworkInterceptor class for intercepting API requests, responses, and exceptions.
///
/// This class extends the [Interceptor] class from the Dio HTTP client library
/// and overrides the [onRequest], [onError] and [onResponse] methods to intercept
/// different stages of the API request lifecycle.
///
/// use this class to add custom logic or perform actions such as logging,
/// modifying headers, or handling errors before and after making API requests.
class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Do something before request is sent
    print('Request sent to: ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with response data
    print('Response received from: ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Do something with response error
    print('Error occurred: ${err.error}');
    return super.onError(err, handler);
  }
}



// import 'dart:convert';
// import 'package:dio/dio.dart';
// import '../../core/utils/pref_utils.dart';
//
// class NetworkInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     // Add the access token to the request headers
//     String? accessToken = await PrefUtils().retrieveToken('access_token');
//     if (accessToken != null) {
//       options.headers['Authorization'] = 'Bearer $accessToken';
//     }
//     return handler.next(options);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     // Do something with response data
//     print('Response received from: ${response.requestOptions.uri}');
//     return handler.next(response);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     // Check if the error is due to an expired token
//     if (err.response?.statusCode == 403) {
//       // Attempt to refresh the token
//       bool tokensRefreshed = await refreshTokens();
//       if (tokensRefreshed) {
//         // Retry the original request with the new token
//         String? newAccessToken = await PrefUtils().retrieveToken('access_token');
//         if (newAccessToken != null) {
//           err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
//           final opts = Options(
//             method: err.requestOptions.method,
//             headers: err.requestOptions.headers,
//           );
//           final cloneReq = await Dio().request(
//             err.requestOptions.path,
//             options: opts,
//             data: err.requestOptions.data,
//             queryParameters: err.requestOptions.queryParameters,
//           );
//           return handler.resolve(cloneReq);
//         }
//       }
//     }
//     return handler.next(err);
//   }
//
//   Future<bool> refreshTokens() async {
//     String? refreshToken = await PrefUtils().retrieveToken('refresh_token');
//     if (refreshToken == null) {
//       return false; // No refresh token available
//     }
//
//     try {
//       Dio dio = Dio();
//       final response = await dio.post(
//         'https://yasil-backend.cymelle.com/auth/api/v1/refresh',
//         data: jsonEncode({'refreshToken': refreshToken}),
//       );
//
//       if (response.statusCode == 200) {
//         String newAccessToken = response.data['accessToken'];
//         await PrefUtils().storeToken('access_token', newAccessToken);
//         return true; // Token refresh successful
//       } else {
//         print('Token refresh failed with status code: ${response.statusCode}');
//         return false; // Token refresh failed
//       }
//     } catch (e) {
//       print('Error refreshing tokens: $e');
//       return false; // Token refresh failed due to an error
//     }
//   }
// }