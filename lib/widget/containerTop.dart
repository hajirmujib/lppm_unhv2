import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/UserM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:lppm_unhv2/widget/dateText.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

import 'myColor.dart';

class ContainerTop extends StatelessWidget {
  ContainerTop({
    Key key,
  }) : super(key: key);
  final UsersC userC = Get.put(UsersC());
  @override
  Widget build(BuildContext context) {
    // final Future<User> user = userC.userLogin();
    return Obx(() {
      if (userC.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        );
      }
      return FutureBuilder(
          future: userC.userLogin(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: MyColor.primaryColor,
                          radius: 10.w,
                          child: CircleAvatar(
                              radius: 9.w,
                              backgroundImage: user.foto == ""
                                  ? AssetImage("asset/image/logo_unh.png")
                                  : NetworkImage(BaseServices().urlFile +
                                      "/api_apk/imageUpload/" +
                                      user.foto)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Center(
                            child: Text(user.nama, style: TitleListText()),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  user.fakultas,
                                  style: DateText(),
                                ),
                                Text(
                                  user.level,
                                  style: DateText(),
                                )
                              ],
                            ),
                            Container(
                              height: 10.h,
                              child: VerticalDivider(
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  user.prodi,
                                  style: DateText(),
                                ),
                                Text(
                                  user.nidn,
                                  style: DateText(),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    width: 100.w,
                    height: 40.h,
                    color: Colors.white,
                    margin: user.level == "dosen"
                        ? EdgeInsets.only(top: 5.h)
                        : EdgeInsets.only(top: 0)),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
