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
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Do something with response error
    print('Error occurred: ${err.error}');
    return super.onError(err, handler);
  }
}
