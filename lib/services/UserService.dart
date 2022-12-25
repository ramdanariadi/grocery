import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService{

  static Future<bool> login(String username, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> body = {"username": username, "password": pass};
    final response = await http.post(Uri.parse(Application.httBaseUrl + "/login"), body: body);
    debugPrint('Response : ' + response.body.toString());
    debugPrint('has code : ' + response.statusCode.toString());
    debugPrint(body.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokens = jsonDecode(response.body)['data'];
      await sharedPreferences.setString("accessToken", tokens['access_token']);
      await sharedPreferences.setString("refreshToken", tokens['refresh_token']);
      await sharedPreferences.setString("userId", tokens['userId']);
      await sharedPreferences.setBool("authenticated", true);
      return true;
    }
    return false;
  }

  static logout(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("accessToken");
    await sharedPreferences.remove("refreshToken");
    await sharedPreferences.setBool("authenticated", false);
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("authenticated") ?? false;
  }

  static Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("userId") ?? null;
  }
}