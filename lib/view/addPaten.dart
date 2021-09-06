import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class AddPaten extends StatelessWidget {
  // const AddJurnal({ Key? key }) : super(key: key);
  final patenC = Get.put(PatenC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Upload Paten",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
        ),
        leading: InkWell(
          onTap: () {
            patenC.file.value = File("");
            patenC.dateController.text = "";
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
              patenC.uploadPaten();
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
                  key: patenC.key,
                  child: Column(
                    children: [
                      Text("Judul Invansi", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 5,
                          onSaved: (e) => patenC.judulInvansi = e,
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
                              hintText: "Judul Invansi",
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
                      Text("No Permohonan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 2,
                          onSaved: (e) => patenC.noPermohonan = e,
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
                              hintText: "No Permohonan",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        width: 90.w,
                        height: 10.h,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("Tgl Pengajuan", style: TitleListText()),
                      InkWell(
                        onTap: () => patenC.selectDate(context),
                        child: Container(
                          child: TextFormField(
                            controller: patenC.dateController,
                            enabled: false,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            maxLines: 1,
                            onSaved: (e) => patenC.tglPengajuan = e,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18),
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.indigo)),
                                hintText: "Tgl Pengajuan",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                          width: 90.w,
                          height: 10.h,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("Pemohon", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => patenC.pemohon = e,
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
                              hintText: "Pemohon",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        width: 90.w,
                        height: 10.h,
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
                                child: patenC.file.value.path == ""
                                    ? Center(
                                        child: Text(
                                        "File Name",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    : Center(
                                        child: Text(
                                        patenC.file.value.path.split('/').last,
                                        style: TextStyle(color: Colors.white),
                                      )))),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: IconButton(
                                onPressed: () => patenC.pickFile(),
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
