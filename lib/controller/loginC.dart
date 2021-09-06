import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/bottomBarCon.dart';
import 'package:lppm_unhv2/services/loginS.dart';
import 'package:lppm_unhv2/view/bottomBar.dart';
import 'package:lppm_unhv2/view/homeView.dart';
import 'package:lppm_unhv2/view/loginView.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginC extends GetxController {
  // final UsersC userC = Get.put(UsersC());
  var loginProcess = false.obs;
  String username = "";
  var password = "";
  final usernameTxt = TextEditingController();
  final passwordTxt = TextEditingController();
  var error = "";
  var isShow = true.obs;
  // Widget level = ProfileLppmView();
  String idUser;
  final BottomBarC bottomBarC = Get.put(BottomBarC());

  void setIsShow() {
    isShow(isShow.value == true ? false : true);
  }

  Future<String> getIdUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return this.idUser = preferences.getString("idUser");
  }

  Future<Widget> goto() async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getString("status");

    if (value == "login") {
      try {
        bool refresh = await this.refresh();
        if (refresh) {
          return BottomBar();
        }
      } catch (e) {
        return LoginView();
      }
    }

    return LoginView();
  }

  Future<void> fetchLogin() async {
    print("username:" + username);
    print("password:" + password);
    try {
      loginProcess(true);
      List loginRes = await LoginS.login(email: username, password: password);
      print(loginRes[0]);

      if (loginRes[0] == "login") {
        error = loginRes[0];
        final pref = await SharedPreferences.getInstance();
        pref.setString("status", loginRes[0]);
        pref.setString("idUser", loginRes[1]);
        pref.setString("level", loginRes[2]);

        Get.to(BottomBar(), transition: Transition.upToDown);
        usernameTxt.clear();
        passwordTxt.clear();
      } else {
        error = loginRes[1];
        print("gagal");
        this.showDialog();
      }
    } finally {
      loginProcess(false);
    }
  }

  Future<bool> refresh() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString("status");

    if (token == "") {
      return false;
    }

    bool succes = false;
    try {
      loginProcess(true);
      if (token != null) {
        succes = true;
      }
    } finally {
      loginProcess(false);
    }

    return succes;
  }

  Future<String> logOut() async {
    var succes = "";
    bottomBarC.indexChange(index: 0);
    bottomBarC.pageSelect(index: HomeView());

    final pref = await SharedPreferences.getInstance();
    pref.remove("level");
    pref.remove("idUser");
    pref.remove("status");

    pref.setString("status", "");
    pref.setString("idUser", "");
    pref.setString("level", "");

    usernameTxt.clear();
    passwordTxt.clear();
    return succes;
  }

  void showDialog() {
    Get.defaultDialog(
      title: "Status Login Gagal",
      middleText: "Password / Email Salah",
      textCancel: "Oke",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
    );
  }
}
