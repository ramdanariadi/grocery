import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequestService {
  static Future<http.Response> get({required String url}) async {
    final dynamic response =
        await http.get(Uri.parse(url), headers: await getHeaders());
    if (response.statusCode == 200) {
      return response;
    }

    if (response.statusCode == 403) {
      refreshToken();
    }
    return response;
  }

  static Future<bool> refreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? '';

    if (refreshToken.trim() == '') return false;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${refreshToken.trim()}"
    };

    final response =
        await http.post(Uri.parse("$HTTPBASEURL/user/token"), headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = jsonDecode(response.body);
      sharedPreferences.setString("access_token", tokens['access_token']);
      sharedPreferences.setString("refresh_token", tokens['refresh_token']);
    } else {
      return false;
    }

    return true;
  }

  static Future<bool> login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> body = {"username": username, "password": password};
    final response =
        await http.post(Uri.parse("$HTTPBASEURL/login"), body: body);
    debugPrint('Response : ' + response.body.toString());
    debugPrint('has code : ' + response.statusCode.toString());
    debugPrint(body.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = jsonDecode(response.body);
      await sharedPreferences.setString("access_token", tokens['access_token']);
      await sharedPreferences.setString(
          "refresh_token", tokens['refresh_token']);
      await sharedPreferences.setBool("authenticated", true);
      return true;
    }
    return false;
  }

  static logout(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("access_token");
    await sharedPreferences.remove("refresh_token");
    await sharedPreferences.setBool("authenticated", true);
  }

  static Future<dynamic> getHeaders() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? '';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${accessToken.trim()}"
    };

    return headers;
  }
}

enum HttpMethod { GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS, TRACE }
