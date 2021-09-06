import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/loginC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/view/lppm/detailAkun.dart';
import 'package:lppm_unhv2/widget/containerTop.dart';
import 'package:lppm_unhv2/widget/menuDashboard.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import '../loginView.dart';

class ProfileDosen extends StatelessWidget {
  // const ProfileDosen({ Key? key }) : super(key: key);
  final UsersC userC = Get.put(UsersC());
  final LoginC loginC = Get.put(LoginC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {
              // userC.userById();
              Get.to(() => DetailAkun());
            },
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: Icon(
                  Icons.settings,
                  size: 20,
                )),
          ),
          InkWell(
            onTap: () async {
              String res = await loginC.logOut();
              if (res != "") {
                Fluttertoast.showToast(msg: "Ada Kesalahan");
              } else {
                Get.offAll(LoginView());
                await loginC.logOut();
              }
            },
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: Icon(
                  Icons.exit_to_app,
                  size: 20,
                )),
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [ContainerTop(), ContainerMidle(), ContainerBottom()],
      )),
    );
  }
}

class ContainerMidle extends StatelessWidget {
  const ContainerMidle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(""),
        ),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
        width: 100.w,
        height: 35.h,
        decoration: BoxDecoration(
            color: MyColor.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      ),
    );
  }
}
