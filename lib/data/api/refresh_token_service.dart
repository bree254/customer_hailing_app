import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/utils/pref_utils.dart';

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {
    'refreshToken': refreshToken,
  };
}

Future<bool> refreshTokens() async {
  String? refreshToken = await PrefUtils().retrieveToken('refresh_token');
  if (refreshToken == null) {
    return false; // No refresh token available
  }

  bool tokensRefreshed = await refreshTokenAPI(refreshToken);
  return tokensRefreshed;
}

Future<bool> refreshTokenAPI(String refreshToken) async {
  try {
    Dio dio = Dio();

    final response = await dio.post(
      'https://yasil-backend.cymelle.com/auth/api/v1/refresh',
      data: jsonEncode(RefreshTokenRequest(refreshToken: refreshToken)),
    );

    if (response.statusCode == 200) {
      String newAccessToken = response.data['accessToken'];
      await PrefUtils().storeToken('access_token', newAccessToken);
      return true; // Token refresh successful
    } else {
      debugPrint('Token refresh failed with status code: ${response.statusCode}');
      return false; // Token refresh failed
    }
  } catch (e) {
    debugPrint('Error refreshing tokens: $e');
    return false; // Token refresh failed due to an error
  }
}