import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class DetailAkun extends StatelessWidget {
  // DetailAkun({
  //   Key key,
  // }) : super(key: key);

  final userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: MyColor.primaryColor),
              child: Icon(Icons.arrow_back)),
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: MyColor.primaryColor, fontFamily: "Poppin"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              Center(
                child: InkWell(
                  onTap: () => userC.editFoto(),
                  child: CircleAvatar(
                    backgroundColor: MyColor.primaryColor,
                    radius: 10.w,
                    child: Obx(() => CircleAvatar(
                          radius: 9.w,
                          backgroundImage: userC.userById().foto == ""
                              ? AssetImage("asset/image/logo_unh.png")
                              : NetworkImage(BaseServices().urlFile +
                                  "/api_apk/imageUpload/" +
                                  userC.userById().foto),
                        )),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: MyColor.primaryColor,
                ),
                title: Text("Nama"),
                subtitle: Obx(() => Text(userC.userById().nama)),
                trailing: IconButton(
                    onPressed: () {
                      userC.editName();
                    },
                    icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.format_list_numbered_sharp,
                  color: MyColor.primaryColor,
                ),
                title: Text("Nidn"),
                subtitle: Obx(() => Text(userC.userById().nidn)),
                trailing: IconButton(
                    onPressed: () => userC.editNidn(), icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.school,
                  color: MyColor.primaryColor,
                ),
                title: Text("Fakultas"),
                subtitle: Obx(() => Text(userC.userById().fakultas)),
                trailing: IconButton(
                    onPressed: () => userC.editFakultas(),
                    icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.school_outlined,
                  color: MyColor.primaryColor,
                ),
                title: Text("Prodi"),
                subtitle: Obx(() => Text(userC.userById().prodi)),
                trailing: IconButton(
                    onPressed: () {
                      userC.editProdi();
                    },
                    icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  color: MyColor.primaryColor,
                ),
                title: Text("Email"),
                subtitle: Obx(() => Text(userC.userById().email)),
                trailing: IconButton(
                    onPressed: () => userC.editEmail(), icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.lock,
                  color: MyColor.primaryColor,
                ),
                title: Text("Password"),
                subtitle: Text("***"),
                trailing: IconButton(
                    onPressed: () => userC.editPass(), icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_applications_rounded,
                  color: MyColor.primaryColor,
                ),
                title: Text("Level"),
                subtitle: Obx(() => Text(userC.userById().level)),
                trailing: IconButton(
                    onPressed: () => userC.editLevel(), icon: Icon(Icons.edit)),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
