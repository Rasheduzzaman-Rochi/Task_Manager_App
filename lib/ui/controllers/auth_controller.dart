import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;
  static int? tokenExpiryTime;  // Added to store token expiry time

  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'user-data';
  static const String _tokenExpiryKey = 'token_expiry_time';  // Key for token expiry time

  // Save user data, access token, and token expiry time
  static Future<void> saveUserData(String accessToken, UserModel model, int expiryTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(
        _userDataKey, jsonEncode(model.toJson())); // Correct JSON storage
    await sharedPreferences.setInt(_tokenExpiryKey, expiryTime);  // Save expiry time
  }

  // Get user data and token expiry time from SharedPreferences
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);

    accessToken = token;

    if (userData != null) {
      try {
        userModel = UserModel.fromJson(jsonDecode(userData)); // Decode JSON properly
      } catch (e) {
        print("Error decoding user data: $e");
        userModel = null; // Reset userModel on error
      }
    } else {
      userModel = null; // Reset userModel if data is missing
    }

    tokenExpiryTime = sharedPreferences.getInt(_tokenExpiryKey);  // Get token expiry time
  }

  // Check if the user is logged in and if the token is still valid
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null) {
      await getUserData();
      return _isTokenExpired() ? false : userModel != null;  // Check if token expired
    }
    return false; // Return false if no token is found
  }

  // Check if the token is expired based on the stored expiry time
  static bool _isTokenExpired() {
    if (tokenExpiryTime == null) return true; // Token is expired or missing
    return DateTime.now().millisecondsSinceEpoch > tokenExpiryTime!;
  }

  // Clear all user data (logout)
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> refreshAccessToken() async {
    try {
      // Assuming the refresh token is stored somewhere (e.g., SharedPreferences or a variable)
      String? refreshToken = 'your_refresh_token_here'; // Replace with actual logic to get the refresh token

      // Make a request to refresh the access token
      final response = await post(
        Uri.parse('https://yourapi.com/refresh-token'), // Replace with your actual API URL
        headers: {
          'Authorization': 'Bearer $refreshToken', // Sending the refresh token in the header or body
        },
        body: jsonEncode({'refreshToken': refreshToken}), // Sending refresh token in the body if required
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Assuming the response returns a new access token and expiry time
        accessToken = data['accessToken'];
        tokenExpiryTime = data['expiryTime'];  // Set new expiry time from the response
        debugPrint("Token refreshed successfully.");
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      debugPrint("Failed to refresh token: $e");
      throw e;  // Propagate the error to be handled in the NetworkCaller
    }
  }
}