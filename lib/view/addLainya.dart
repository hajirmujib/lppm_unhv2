import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/lainyaC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class AddLainya extends StatelessWidget {
  // const AddJurnal({ Key? key }) : super(key: key);
  final lainyaC = Get.put(LainnyaC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Upload Lainya",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
        ),
        leading: InkWell(
          onTap: () {
            lainyaC.file.value = File("");

            Get.back();
          },
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
            onTap: () {
              lainyaC.uploadLainya();
            },
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
      body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: lainyaC.key,
                  child: Column(
                    children: [
                      Text("Nama", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 5,
                          onSaved: (e) => lainyaC.nama = e,
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.indigo)),
                              hintText: "Nama",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        width: 90.w,
                        height: 15.h,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("Keterangan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 3,
                          onSaved: (e) => lainyaC.keterangan = e,
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.indigo)),
                              hintText: "Keterangan",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        width: 90.w,
                        height: 15.h,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("File", style: TitleListText()),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 15, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 60.w,
                                height: 20.h,
                                child: lainyaC.file.value.path == ""
                                    ? Center(
                                        child: Text(
                                        "File Name",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    : Center(
                                        child: Text(
                                        lainyaC.file.value.path.split('/').last,
                                        style: TextStyle(color: Colors.white),
                                      )))),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: IconButton(
                                onPressed: () => lainyaC.pickFile(),
                                icon: Icon(
                                  Icons.attach_file,
                                  color: MyColor.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: MyColor.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ))),
    );
  }
}
