import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/view/lppm/addAkun.dart';
import 'package:lppm_unhv2/view/searchUser.dart';
import 'package:lppm_unhv2/widget/listUser.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import 'detailAkun.dart';

class AkunLppmView extends StatelessWidget {
  // const AkunLppmView({Key key}) : super(key: key);
  final userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColor.primaryColor,
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            showSearch(context: context, delegate: SearchUser());
          }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Akun",
          style: TextStyle(color: Colors.white, fontFamily: "Poppin"),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: MyColor.primaryColor,
              )),
        ),
        actions: [
          InkWell(
            onTap: () => Get.to(AddAkun()),
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: MyColor.primaryColor,
                )),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: userC.fetchUser,
        child: SafeArea(
          child: Obx(() {
            if (userC.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (userC.userList.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    width: 80.w,
                    height: 30.h,
                    child: Center(
                      child: Text("Data Belum Ada"),
                    ),
                  ),
                ),
              );
            }
            return Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: userC.userList.length ?? 0,
                  itemBuilder: (BuildContext context, int i) {
                    var x = userC.userList[i];
                    return InkWell(
                      onTap: () {
                        userC.idU.value = x.idUsers;
                        Get.to(
                          () => DetailAkun(),
                        );
                      },
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: ListUserItem(
                          image: x.foto,
                          title: x.nama,
                          nidn: x.nidn,
                          level: x.level,
                        ),
                        actions: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            child: IconSlideAction(
                              caption: "Hapus",
                              foregroundColor: Colors.white,
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                userC.idU.value = x.idUsers;
                                userC.showDialog();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }),
        ),
      ),
    );
  }
}
