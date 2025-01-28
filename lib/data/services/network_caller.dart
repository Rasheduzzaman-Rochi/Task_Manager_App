import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final String? errorMessage;
  final bool isSuccess;

  NetworkResponse(
      {required this.statusCode,
      this.responseData,
      this.errorMessage,
      required this.isSuccess});
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest(
      {required String url, Map<String, dynamic>? params}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      Response response = await get(uri);
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response Code => ${response.body}');
      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            responseData: decodeResponse,
            isSuccess: true);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }
}