import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequestService {
  // static Future<http.Response> get({required String url, bool isSecure = false}) async {
  //   final response = await http.get(Uri.parse(url), headers: await getHeaders(isSecure: isSecure));
  //   debugPrint("Response body " + response.body.toString());

  //   if (response.statusCode == 403) {
  //     refreshToken();
  //   }
  //   return response;
  // }

  // static Future<http.Response> post({required String url, bool isSecure = false, Object? body}) async {
  //   final response = await http.post(Uri.parse(url), body: body, headers: await getHeaders(isSecure: isSecure));

  //   debugPrint("Response " + response.body.toString() + " code : " + response.statusCode.toString());

  //   if (response.statusCode == 403) {
  //     await refreshToken();
  //   }

  //   return response;
  // }

  static Future<http.Response> sendRequest({required HttpMethod method, required String url, bool isSecure = false, Object? body}) async {
      http.Response response = new http.Response("NOT_FOUND", 404);
    
    switch(method){
      case HttpMethod.GET:
        response = await http.get(Uri.parse(url), headers: await getHeaders(isSecure: isSecure));
      break;
      case HttpMethod.POST:
        response = await http.post(Uri.parse(url), body: body, headers: await getHeaders(isSecure: isSecure));
        break;
      case HttpMethod.PUT:
        // TODO: Handle this case.
        break;
      case HttpMethod.PATCH:
        // TODO: Handle this case.
        break;
      case HttpMethod.DELETE:
        // TODO: Handle this case.
        break;
      case HttpMethod.OPTIONS:
        // TODO: Handle this case.
        break;
    }

    debugPrint("Response " + response.body.toString() + " code : " + response.statusCode.toString());

    if (response.statusCode == 403) {
      await refreshToken();
    }

    return response;
  }

  static Future<bool> refreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String refreshToken = sharedPreferences.getString("refresh_token") ?? '';

    if (refreshToken.trim() == '') return false;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${refreshToken.trim()}"
    };

    final response = await http.get(Uri.parse(Application.httBaseUrl + "/user/token"), headers: headers);

    await sharedPreferences.setBool("authenticated", false);
    debugPrint("response get token : " + response.body.toString() + " code : " + response.statusCode.toString());
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = jsonDecode(response.body);
      await sharedPreferences.setString("access_token", tokens['access_token']);
      await sharedPreferences.setString("refresh_token", tokens['refresh_token']);
      await sharedPreferences.setBool("authenticated", true);
      debugPrint("refresh token : " + tokens.toString());
      return true;
    } 

    return false;
  }

  static Future<bool> login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> body = {"username": username, "password": password};
    final response = await http.post(Uri.parse(Application.httBaseUrl + "/login"), body: body);
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

  static Future<dynamic> getHeaders({bool isSecure = false})async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    Map<String, String> headers = {
      "Content-Type": "application/json"
    };

    if(isSecure){
      final String accessToken = sharedPreferences.getString("access_token") ?? '';
      headers.addAll(Map.of({"Authorization": "Bearer ${accessToken.trim()}"}));
    }

    debugPrint("Headers : " + headers.toString());

    return headers;
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("authenticated") ?? false;
  }
}

enum HttpMethod { GET, POST, PUT, PATCH, DELETE, OPTIONS }
