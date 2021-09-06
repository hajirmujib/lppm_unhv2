import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/informasiC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class AddInfo extends StatelessWidget {
  final infoC = Get.find<InformasiC>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Tambah Informasi",
          style: TextStyle(
              fontFamily: "Poppins Bold", color: MyColor.primaryColor),
        ),
        leading: InkWell(
          onTap: () {
            infoC.lampiran.value = File("");
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
        actions: [
          InkWell(
            onTap: () => infoC.uploadInformasi(),
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: infoC.key,
              child: Center(
                child: Container(
                    width: 90.w,
                    height: 10.h,
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Tidak Boleh Kosong";
                        }
                        return null;
                      },
                      onSaved: (e) => infoC.judulInformasi = e,
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: MyColor.primaryColor,
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Judul Artikel",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          prefixIcon: Icon(
                            Icons.text_format,
                            color: Colors.grey,
                          ),
                          fillColor: Colors.white,
                          filled: true),
                    )),
              ),
            ),
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
                      child: infoC.lampiran.value.path == ""
                          ? Center(
                              child: Text(
                              "File Name",
                              style: TextStyle(color: Colors.white),
                            ))
                          : Center(
                              child: Text(
                              infoC.lampiran.value.path.split('/').last,
                              style: TextStyle(color: Colors.white),
                            )))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: IconButton(
                      onPressed: () => infoC.pickLampiran(),
                      icon: Icon(
                        Icons.attach_file,
                        color: MyColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FlutterSummernote(
              height: 50.h,
              hint: "Your text here...",
              key: infoC.keyEditor,
              hasAttachment: false,
              customToolbar: """
            
            [
              ['style', ['bold', 'italic', 'underline', 'clear']],
              ['font', ['strikethrough', 'superscript', 'subscript']],
              ['insert', ['link', 'table', 'hr']]
            ]
                  """,
            ),
          ],
        ),
      )),
    );
  }
}
