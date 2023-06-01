import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  bool? authenticated;
  String? userId;
  static UserService? _userService;

  static getInstance() {
    if (_userService == null) {
      _userService = UserService();
    }
    return _userService;
  }

  static Future<bool> login(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> body = {"email": email, "password": pass};
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.POST,
        url: Application.httBaseUrl + "/user/login",
        body: body);
    debugPrint('Response : ' + response.body.toString());
    debugPrint('has code : ' + response.statusCode.toString());
    debugPrint(body.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = jsonDecode(response.body)['data'];
      await sharedPreferences.setString("accessToken", tokens['accessToken']);
      await sharedPreferences.setString("refreshToken", tokens['refreshToken']);
      await sharedPreferences.setBool("authenticated", true);

      UserService userService = UserService.getInstance();
      userService.authenticated = true;

      return true;
    }
    return false;
  }

  static logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("accessToken");
    await sharedPreferences.remove("refreshToken");
    await sharedPreferences.setBool("authenticated", false);
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserService userService = UserService.getInstance();
    userService.authenticated =
        sharedPreferences.getBool("authenticated") ?? false;
    userService.userId = sharedPreferences.getString("userId") ?? null;
    return sharedPreferences.getBool("authenticated") ?? false;
  }

  static Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserService userService = UserService.getInstance();
    userService.authenticated =
        sharedPreferences.getBool("authenticated") ?? false;
    userService.userId = sharedPreferences.getString("userId") ?? null;
    return userService.userId;
  }
}
