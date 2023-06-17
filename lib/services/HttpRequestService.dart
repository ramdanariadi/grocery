import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE, OPTIONS }

class HttpRequestService {

  static Future<http.Response> sendRequest({required HttpMethod method, required String url, bool isSecure = false, Object? body}) async {
    http.Response response = new http.Response("NOT_FOUND", 404);
    
    switch(method){
      case HttpMethod.GET:
        response = await http.get(Uri.parse(url), headers: await getHeaders(isSecure: isSecure));
      break;
      case HttpMethod.POST:
        response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: await getHeaders(isSecure: isSecure));
      break;
      case HttpMethod.PUT:
        // TODO: Handle this case.
      break;
      case HttpMethod.PATCH:
        // TODO: Handle this case.
        break;
      case HttpMethod.DELETE:
        response = await http.delete(Uri.parse(url), body: body, headers: await getHeaders(isSecure: isSecure));
        break;
      case HttpMethod.OPTIONS:
        // TODO: Handle this case.
      break;
    }
    
    debugPrint("has code : ${response.statusCode}");
    if (response.statusCode == 403) {
      debugPrint("get refresh token");
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
      final Map<String, dynamic> tokens = jsonDecode(response.body)['data'];
      await sharedPreferences.setString("accessToken", tokens['accessToken']);
      await sharedPreferences.setString("refreshToken", tokens['refreshoken']);
      await sharedPreferences.setBool("authenticated", true);
      debugPrint("refresh token : " + tokens.toString());
      return true;
    } 

    return false;
  }

  static Future<dynamic> getHeaders({bool isSecure = false})async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    Map<String, String> headers = {
      "Content-Type": "application/json"
    };

    if(isSecure){
      final String accessToken = sharedPreferences.getString("accessToken") ?? '';
      headers.addAll(Map.of({"Authorization": "Bearer ${accessToken.trim()}"}));
    }

    debugPrint("Headers : " + headers.toString());

    return headers;
  }
}