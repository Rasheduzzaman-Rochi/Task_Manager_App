import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/signIn_screen.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final String errorMessage;
  final bool isSuccess;

  NetworkResponse(
      {required this.statusCode,
        this.responseData,
        this.errorMessage = 'Something went wrong!',
        required this.isSuccess});
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest(
      {required String url, Map<String, dynamic>? params}) async {
    // Check if the token is expired before making the request
    if (AuthController.accessToken == null || await _isTokenExpired()) {
      await _refreshToken();
    }

    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      Response response =
      await get(uri, headers: {'token': AuthController.accessToken ?? ''});
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response Body => ${response.body}');

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            responseData: decodeResponse,
            isSuccess: true);
      } else if (response.statusCode == 401) {
        await _logout();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    // Check if the token is expired before making the request
    if (AuthController.accessToken == null || await _isTokenExpired()) {
      await _refreshToken();
    }

    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      debugPrint('BODY => $body');
      Response response = await post(uri,
          headers: {
            'Content-Type': 'application/json',
            'token': AuthController.accessToken ?? ''
          },
          body: jsonEncode(body));
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response Body => ${response.body}');

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            responseData: decodeResponse,
            isSuccess: true);
      } else if (response.statusCode == 401) {
        await _logout();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<bool> _isTokenExpired() async {
    // Fetch token expiry time from AuthController or SharedPreferences
    int? expiryTime = AuthController.tokenExpiryTime;
    if (expiryTime == null) return true; // No token or expired
    return DateTime.now().millisecondsSinceEpoch > expiryTime;
  }

  static Future<void> _refreshToken() async {
    // Try refreshing the token
    try {
      // Assuming there's a method in AuthController to refresh the token
      await AuthController.refreshAccessToken();
      debugPrint("Token refreshed successfully.");
    } catch (e) {
      debugPrint("Failed to refresh token: $e");
      await _logout(); // If refresh fails, logout the user
    }
  }

  static Future<void> _logout() async {
    AuthController.clearUserData();

    // Ensure the context is available before navigating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(
          TaskManagerApp.navigatorkey.currentContext!,
          SigninScreen.name,
              (_) => false);
    });
  }
}
