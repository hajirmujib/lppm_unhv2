import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class AddAkun extends StatelessWidget {
  // const AddAkun({ Key? key }) : super(key: key);
  final UsersC userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            userC.foto.value = File("");
            Get.back();
          },
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: MyColor.primaryColor),
              child: Icon(Icons.arrow_back)),
        ),
        title: Text(
          "Tambah Akun",
          style: TextStyle(color: MyColor.primaryColor, fontFamily: "Poppin"),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => userC.uploadUser(),
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: Icon(
                  Icons.done_all,
                  size: 20,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Form(
        key: userC.key,
        child: SafeArea(
          child: Container(
            width: 100.w,
            height: 100.h,
            padding: EdgeInsets.all(5),
            child: ListView(
              children: [
                Center(
                  child: InkWell(
                    onTap: () => userC.pickLampiran(),
                    child: CircleAvatar(
                      backgroundColor: MyColor.primaryColor,
                      radius: 10.w,
                      child: Obx(() => CircleAvatar(
                          radius: 9.w,
                          backgroundImage: userC.foto.value.path == ""
                              ? AssetImage("asset/image/logo_unh.png")
                              : FileImage(userC.foto.value))),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: MyColor.primaryColor,
                  ),
                  title: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Tidak Boleh Kosong";
                      }
                      return null;
                    },
                    onSaved: (e) => userC.nama = e,
                    decoration: InputDecoration(
                        hintText: "Nama",
                        hintStyle: TextStyle(fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: MyColor.primaryColor,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.format_list_numbered_sharp,
                    color: MyColor.primaryColor,
                  ),
                  title: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Tidak Boleh Kosong";
                      }
                      return null;
                    },
                    onSaved: (e) => userC.nidn = e,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Nidn",
                        hintStyle: TextStyle(fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: MyColor.primaryColor,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
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
                  subtitle: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primaryColor)),
                    child: DropdownButtonFormField<String>(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text("Ilmu Komputer"),
                            value: "Ilmu Komputer",
                          ),
                          DropdownMenuItem(
                            child: Text("Ilmu Sosial & Politik"),
                            value: "Ilmu Sosial & Politik",
                          ),
                        ],
                        onChanged: (String value) {
                          userC.fakultas = value;
                        }),
                  ),
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
                  subtitle: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primaryColor)),
                    child: DropdownButtonFormField<String>(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Tidak Boleh Kosong";
                        }
                        return null;
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text("Teknik Informatika"),
                          value: "Teknik Informatika",
                        ),
                        DropdownMenuItem(
                          child: Text("Sistem Informasi"),
                          value: "Sistem Informasi",
                        ),
                        DropdownMenuItem(
                          child: Text("Ilmu Pemerintahan"),
                          value: "Ilmu Pemerintahan",
                        ),
                        DropdownMenuItem(
                          child: Text("Ilmu Komunikasi"),
                          value: "Ilmu Komunikasi",
                        ),
                        DropdownMenuItem(
                          child: Text("Teknologi Informasi"),
                          value: "Teknologi Informasi",
                        ),
                      ],
                      onChanged: (String value) {
                        userC.prodi = value;
                      },
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.message,
                    color: MyColor.primaryColor,
                  ),
                  title: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Tidak Boleh Kosong";
                      }
                      return null;
                    },
                    onSaved: (e) => userC.email = e,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: MyColor.primaryColor,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: MyColor.primaryColor,
                  ),
                  title: Obx(() => TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        onSaved: (e) => userC.password = e,
                        obscureText: userC.isShow.value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: MyColor.primaryColor,
                            )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.grey))),
                      )),
                  trailing: Obx(() => IconButton(
                      onPressed: () => userC.setIsShow(),
                      icon: Icon(userC.isShow.value == true
                          ? Icons.visibility_off
                          : Icons.visibility))),
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
                  subtitle: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primaryColor)),
                    child: DropdownButtonFormField<String>(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Tidak Boleh Kosong";
                        }
                        return null;
                      },
                      hint: Text("Status User"),
                      items: [
                        DropdownMenuItem(
                          child: Text("Dosen"),
                          value: "dosen",
                        ),
                        DropdownMenuItem(
                          child: Text("Reviewer"),
                          value: "reviewer",
                        ),
                        DropdownMenuItem(
                          child: Text("LPPM"),
                          value: "lppm",
                        ),
                      ],
                      onChanged: (String value) {
                        userC.level = value;
                      },
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
