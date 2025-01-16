import 'dart:convert';

import 'package:customer_hailing/data/models/auth/user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class PrefUtils extends GetxController {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    init();
  }

  Future<void> init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      debugPrint('SharedPreference Initialized');
    }
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
    update();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }

  Future<void> setStringList(String key, List<String> value) {
    return _sharedPreferences!.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences!.getStringList(key);
  }

  /// Saves the access token or refresh token independently.
  Future<void> storeToken(String tokenType, String tokenValue) async {
    String key;
    if (tokenType == 'access_token') {
      key = 'access_token';
    } else if (tokenType == 'refresh_token') {
      key = 'refresh_token';
    } else {
      throw ArgumentError('Invalid token type. Must be \'access_token\' or \'refresh_token\'');
    }

    await _sharedPreferences!.setString(key, tokenValue);
  }

  /// Retrieves the access token or refresh token independently.
  retrieveToken(String tokenType) async {
    String key;
    if (tokenType == 'access_token') {
      key = 'access_token';
    } else if (tokenType == 'refresh_token') {
      key = 'refresh_token';
    } else {
      throw ArgumentError('Invalid token type. Must be \'access_token\' or \'refresh_token\'');
    }

    return _sharedPreferences!.getString(key); // Return empty string if not found
  }
  Future<void> saveUsername(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  Future<String?> retrieveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  Future<void> addPastDestination(String destination) async {
    List<String> pastDestinations = getStringList('pastDestinations') ?? [];
    if (!pastDestinations.contains(destination)) {
      pastDestinations.add(destination);
      await setStringList('pastDestinations', pastDestinations);
      update();
    }
  }

  List<String> getPastDestinations() {
    return getStringList('pastDestinations') ?? [];
  }

  Future<void> setUserData(UserResponse user) {
    return _sharedPreferences!.setString('userData', json.encode(user));
  }

  UserResponse? getUserData() {
    final userDataString = _sharedPreferences!.getString('userData');
    if (userDataString != null) {
      return UserResponse.fromJson(jsonDecode(userDataString));
    }
    return null;
  }


  getFcmToken() async {
    return _sharedPreferences!.getString('fcm_token');
  }

  void setFcmToken(String fcmToken) {
    _sharedPreferences!.setString('fcm_token', fcmToken);
  }
}
