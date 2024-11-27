import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../core/utils/pref_utils.dart';
import '../data/api/endpoints.dart';


class AuthInterceptor {
  late String accessToken;
  late String refreshToken;
 // String userUrl = Endpoints.baseUrlUser;

  AuthInterceptor() {
    // Initialize tokens asynchronously
    _initializeTokens();
  }

  Future<void> _initializeTokens() async {
    PrefUtils prefUtils = PrefUtils();
    await prefUtils.init();
    accessToken = await PrefUtils().retrieveToken('access_token') ?? '';
    refreshToken = await PrefUtils().retrieveToken('refresh_token') ?? '';
  }

  String getAccessToken() {
    return accessToken;
  }

  bool isTokenValid(String token) {
    // Implement token validity check, e.g., for JWT, check expiration
    // Example: Decoding JWT and checking expiration claim
    // For demonstration purposes, a simple check is shown
    if (token.isNotEmpty) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      if (decodedToken.containsKey('exp')) {
        // Retrieve expiry time from the token
        int expiryTimeInSeconds = decodedToken['exp'];

        // Calculate expiry DateTime from seconds since epoch
        DateTime expiryDateTime = DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000);

        // Check if the token has expired
        return expiryDateTime.isAfter(DateTime.now());
      }
    }
    return false;
  }

  // Future<bool> refreshTokens() async {
  //   // Example assumes a hypothetical refreshTokenAPI function
  //   bool tokensRefreshed = await refreshTokenAPI(refreshToken);
  //   if (tokensRefreshed) {
  //     return true;
  //   } else {
  //     return false; // Token refresh failed
  //   }
  // }

  //
  // Future<bool> refreshTokenAPI(String refreshToken) async {
  //   try {
  //     // Initialize Dio
  //     Dio dio = Dio();
  //     //TODO: Headers
  //     // dio.options.headers['Authorization'] = 'Bearer $refreshToken';
  //     // Implement your token refresh API call here
  //     final response = await dio.post(
  //       '${userUrl}refreshToken',
  //       data: jsonEncode(RefreshTokenRequest(refreshToken: refreshToken)),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Assuming the server responds with a new access token
  //       String newAccessToken = response.data['access_token'];
  //
  //       // Update the access token in storage after successful refresh
  //       PrefUtils().storeToken('access_token', newAccessToken);
  //       // await _storage.write(key: 'access_token', value: newAccessToken);
  //
  //       // Update the accessToken variable in the class
  //       accessToken = newAccessToken;
  //
  //       return true; // Token refresh successful
  //     } else {
  //       return false; // Token refresh failed
  //     }
  //   } catch (e) {
  //     debugPrint('Error refreshing tokens: $e');
  //     return false; // Token refresh failed due to an error
  //   }
  // }
}
