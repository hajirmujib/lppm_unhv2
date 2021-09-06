import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/bottomBarCon.dart';
import 'package:lppm_unhv2/controller/loginC.dart';
import 'package:lppm_unhv2/view/dosen/profileDosen.dart';

import 'package:lppm_unhv2/view/homeView.dart';
import 'package:lppm_unhv2/view/listInfoView.dart';
import 'package:lppm_unhv2/view/listJurnalView.dart';
import 'package:lppm_unhv2/view/reviewer/profileReviewer.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lppm/profileLppmView.dart';

class BottomBar extends StatelessWidget {
  final BottomBarC bottomBarC = Get.put(BottomBarC());
  final LoginC loginC = Get.put(LoginC());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: GNav(
            padding: EdgeInsets.all(12),
            tabMargin: EdgeInsets.all(5),
            activeColor: MyColor.secondaryColor,
            hoverColor: MyColor.secondaryColor,
            rippleColor: MyColor.secondaryColor,
            duration: Duration(milliseconds: 2),
            // backgroundColor: MyColor.primaryColor,
            tabBorderRadius: 10,
            tabActiveBorder: Border.all(color: MyColor.thirdaryColor, width: 1),
            // tabBackgroundColor: MyColor.thirdaryColor,
            tabs: [
              GButton(
                onPressed: () {
                  bottomBarC.indexChange(index: 0);
                  bottomBarC.pageSelect(index: HomeView());
                },
                icon: LineIcons.home,
                iconActiveColor: MyColor.primaryColor,
                textColor: MyColor.primaryColor,
                text: 'Home',
              ),
              GButton(
                onPressed: () {
                  bottomBarC.indexChange(index: 1);
                  bottomBarC.pageSelect(index: ListJurnalView());
                },
                iconActiveColor: MyColor.primaryColor,
                textColor: MyColor.primaryColor,
                icon: LineIcons.book,
                text: 'Jurnal',
              ),
              GButton(
                onPressed: () {
                  bottomBarC.indexChange(index: 2);
                  bottomBarC.pageSelect(index: ListInfoView());
                },
                iconActiveColor: MyColor.primaryColor,
                textColor: MyColor.primaryColor,
                icon: LineIcons.info,
                text: 'Informasi',
              ),
              GButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();

                  final levels = pref.getString("level");
                  bottomBarC.indexChange(index: 3);

                  if (levels == "lppm") {
                    bottomBarC.pageSelect(index: ProfileLppmView());
                  } else if (levels == "dosen") {
                    bottomBarC.pageSelect(index: ProfileDosen());
                  } else {
                    bottomBarC.pageSelect(index: ProfileReviewer());
                  }
                },
                iconActiveColor: MyColor.primaryColor,
                textColor: MyColor.primaryColor,
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],

            selectedIndex: bottomBarC.currentIndex.value,
          ),
          body: PageStorage(
              bucket: bottomBarC.bucket, child: bottomBarC.currentScreen),
        ));
  }
}
