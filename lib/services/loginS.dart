import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lppm_unhv2/model/UserM.dart';

import 'baseServices.dart';
import 'package:http/http.dart' as http;

class LoginS {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  static var dio = Dio();

  static Future<List> login({String email, String password}) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };
    var result = [];
    // var response =
    //     await http.post(Uri.http(url, "/auth/login"), body: loginData);
    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/Auth/login"),
        body: loginData);

    final Map<String, dynamic> resUser = json.decode(response.body);

    if (resUser['status'] == true) {
      final resData = userModelFromJson(response.body);
      final List<User> user = resData.data;
      result = [
        "login",
        user[0].idUsers,
        user[0].level,
      ];
    } else {
      result = ["not loggin", "Password / Email Salah", null];
    }
    return result;
  }

  // static Future<dynamic> login({String email, String password}) async {
  //   final Map<String, dynamic> loginData = {
  //     'email': email,
  //     'password': password
  //   };
  //   var result = [];

  //   Response response =
  //       await dio.post(url + "/api/Auth/login", data: loginData);

  //   // final resUser = UserModel.fromJson(response.data);

  //   // if (resUser.status == true) {
  //   //   final List<User> user = resUser.data;
  //   //   result = [
  //   //     "login",
  //   //     user[0].idUsers,
  //   //     user[0].level,
  //   //   ];
  //   // } else {
  //   //   result = ["logout", "Password / Email Salah", null];
  //   // }
  //   return response.data;
  // }
}
