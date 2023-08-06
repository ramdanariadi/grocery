import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  bool? authenticated;
  String? userId;
  String? address;
  static UserService? _userService;

  static getInstance() {
    if (_userService == null) {
      _userService = UserService();
    }
    return _userService;
  }

  static Future<bool> login(String email, String pass) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = const FlutterSecureStorage();
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
      await storage.write(key: "accessToken", value: tokens['accessToken']);
      await storage.write(key: "refreshToken", value: tokens['refreshToken']);
      await storage.write(key: "username", value: user['username']);
      await storage.write(key: "userId", value: user['userId']);
      await storage.write(key: "name", value: user['name']);
      await storage.write(key: "email", value: user['email']);
      await storage.write(
          key: "mobilePhoneNumber", value: user['mobilePhoneNumber']);
      await sharedPreferences.setBool("authenticated", true);

      UserService userService = UserService.getInstance();
      userService.authenticated = true;

      return true;
    }
    return false;
  }

  static Future<bool> register(String email, String pass, String username,
      String moiblePhoneNumber) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = const FlutterSecureStorage();
    Map<String, String> body = {
      "email": email,
      "password": pass,
      "username": username,
      "mobilePhoneNumber": moiblePhoneNumber
    };
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
      await storage.write(key: "accessToken", value: tokens['accessToken']);
      await storage.write(key: "refreshToken", value: tokens['refreshToken']);
      await storage.write(key: "username", value: user['username']);
      await storage.write(key: "userId", value: user['userId']);
      await storage.write(key: "name", value: user['name']);
      await storage.write(key: "email", value: user['email']);
      await storage.write(
          key: "mobilePhoneNumber", value: user['mobilePhoneNumber']);
      await sharedPreferences.setBool("authenticated", true);

      UserService userService = UserService.getInstance();
      userService.authenticated = true;

      return true;
    }
    return false;
  }

  static logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = const FlutterSecureStorage();
    await storage.deleteAll();
    await sharedPreferences.setBool("authenticated", false);
    UserService userService = UserService.getInstance();
    userService.authenticated = false;
    userService.userId = "";
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
    FlutterSecureStorage storage = const FlutterSecureStorage();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserService userService = UserService.getInstance();
    userService.authenticated =
        sharedPreferences.getBool("authenticated") ?? false;
    UserProfileDTO user = UserProfileDTO(
        isAuthenticated: userService.authenticated!,
        userId: await storage.read(key: "userId"),
        username: await storage.read(key: "username"),
        name: await storage.read(key: "name"),
        email: await storage.read(key: "email"),
        mobilePhoneNumber: await storage.read(key: "mobilePhoneNumber"),
        address: userService.address);
    return user;
  }
}

class UserProfileDTO {
  UserProfileDTO(
      {this.isAuthenticated = false,
      this.userId,
      this.username,
      this.name,
      this.email,
      this.mobilePhoneNumber,
      this.address});

  bool isAuthenticated;
  String? userId;
  String? username;
  String? name;
  String? email;
  String? mobilePhoneNumber;
  String? address;
}
