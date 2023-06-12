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
      final Map<String, dynamic> user = tokens['user'];
      await sharedPreferences.setString("accessToken", tokens['accessToken']);
      await sharedPreferences.setString("refreshToken", tokens['refreshToken']);
      await sharedPreferences.setString("username", user['username']);
      await sharedPreferences.setString("name", user['name']);
      await sharedPreferences.setString("email", user['email']);
      await sharedPreferences.setString(
          "mobilePhoneNumber", user['mobilePhoneNumber']);
      await sharedPreferences.setBool("authenticated", true);

      UserService userService = UserService.getInstance();
      userService.authenticated = true;

      return true;
    }
    return false;
  }

  static Future<bool> register(String email, String pass, String username,
      String moiblePhoneNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> body = {"email": email, "password": pass};
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.POST,
        url: Application.httBaseUrl + "/user/register",
        body: body);
    debugPrint('Response : ' + response.body.toString());
    debugPrint('has code : ' + response.statusCode.toString());
    debugPrint(body.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = jsonDecode(response.body)['data'];
      final Map<String, dynamic> user = tokens['user'];
      await sharedPreferences.setString("accessToken", tokens['accessToken']);
      await sharedPreferences.setString("refreshToken", tokens['refreshToken']);
      await sharedPreferences.setString("username", user['username']);
      await sharedPreferences.setString("name", user['name']);
      await sharedPreferences.setString("email", user['email']);
      await sharedPreferences.setString(
          "mobilePhoneNumber", user['mobilePhoneNumber']);

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
    await sharedPreferences.remove("username");
    await sharedPreferences.remove("name");
    await sharedPreferences.remove("email");
    await sharedPreferences.remove("mobilePhoneNumber");
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

  static Future<UserProfileDTO> getUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserService userService = UserService.getInstance();
    userService.authenticated =
        sharedPreferences.getBool("authenticated") ?? false;
    UserProfileDTO user = UserProfileDTO(
        isAuthenticated: userService.authenticated!,
        username: sharedPreferences.getString("username"),
        name: sharedPreferences.getString("name"),
        email: sharedPreferences.getString("email"),
        mobilePhoneNumber: sharedPreferences.getString("mobilePhoneNumber"));
    return user;
  }
}

class UserProfileDTO {
  UserProfileDTO(
      {bool this.isAuthenticated = false,
      String? this.username,
      String? this.name,
      String? this.email,
      String? this.mobilePhoneNumber});

  bool isAuthenticated;
  String? username;
  String? name;
  String? email;
  String? mobilePhoneNumber;
}
