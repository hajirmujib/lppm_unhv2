import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/artikelC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class AddArtikel extends StatelessWidget {
  // const AddArtikel({Key key}) : super(key: key);

  final ArtikelC ar = Get.put(ArtikelC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Tambah Artikel",
            style: TextStyle(
                fontFamily: "Poppins Bold", color: MyColor.primaryColor),
          ),
          leading: InkWell(
            onTap: () {
              ar.lampiran.value = File("");
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
              onTap: () => ar.uploadArtikel(),
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
            child: Form(
              key: ar.key,
              child: Column(
                children: [
                  Center(
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
                          onSaved: (e) => ar.judulArtikel = e,
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
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 15, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ar.lampiran.value.path != ""
                                  ? Image.file(
                                      ar.lampiran.value,
                                      width: 60.w,
                                    )
                                  : Image.asset(
                                      "asset/image/logo_unh.png",
                                      width: 60.w,
                                    ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: IconButton(
                            onPressed: () => ar.pickLampiran(),
                            icon: Icon(
                              Icons.photo_library,
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
                    key: ar.keyEditor,
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
            ),
          ),
        ));
  }
}
