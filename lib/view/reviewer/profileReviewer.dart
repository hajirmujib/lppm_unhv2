import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/bottomBarCon.dart';
import 'package:lppm_unhv2/controller/loginC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/view/loginView.dart';
import 'package:lppm_unhv2/view/reviewer/usulanBaruR.dart';
import 'package:lppm_unhv2/view/reviewer/usulanDiterimaR.dart';
import 'package:lppm_unhv2/view/reviewer/usulanRevisiR.dart';
import 'package:lppm_unhv2/widget/containerTop.dart';
import 'package:lppm_unhv2/widget/menuDashboard.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import '../lppm/detailAkun.dart';

class ProfileReviewer extends StatelessWidget {
  // const ProfileReviewer({ Key? key }) : super(key: key);
  final UsersC userC = Get.put(UsersC());
  final LoginC loginC = Get.put(LoginC());
  final BottomBarC bottomBarC = Get.put(BottomBarC());

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
  final proposalC = Get.put(UsulanProposalC());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  proposalC.revUsulanProposal();
                  proposalC.status.value = "Diterima";
                  Get.to(() => UsulanDiterimaR());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColor.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 27.w,
                  height: 13.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LineIcon.bookOpen(color: Colors.white),
                      Text(
                        "Porposal \n Diterima",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppin Regular",
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  proposalC.revUsulanProposal();
                  proposalC.status.value = "Revisi";
                  Get.to(() => UsulanRevisiR());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColor.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 27.w,
                  height: 13.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LineIcon.book(
                        color: Colors.white,
                      ),
                      Text(
                        "Revisi \n Proposal",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppin Regular",
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  proposalC.revUsulanProposal();
                  proposalC.status.value = "Review";
                  Get.to(() => UsulanBaruR());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColor.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 27.w,
                  height: 13.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        color: Colors.white,
                      ),
                      Text(
                        "Proposal \n Baru",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppin Regular",
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
        width: 100.w,
        height: 49.h,
        decoration: BoxDecoration(
            color: MyColor.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      ),
    );
  }
}
