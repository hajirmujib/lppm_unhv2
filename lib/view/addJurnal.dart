import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class AddJurnal extends StatelessWidget {
  // const AddJurnal({ Key? key }) : super(key: key);
  final jurnalC = Get.put(JurnalC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Upload Jurnal",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
        ),
        leading: InkWell(
          onTap: () {
            jurnalC.abstrak.value = File("");
            jurnalC.cover.value = File("");
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
              jurnalC.uploadJurnal();
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
                  key: jurnalC.key,
                  child: Column(
                    children: [
                      Text("Judul Jurnal", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 5,
                          onSaved: (e) => jurnalC.judulJurnal = e,
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
                              hintText: "Judul Jurnal",
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
                      Text("Link", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 2,
                          onSaved: (e) => jurnalC.link = e,
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
                              hintText: "Link",
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
                      Text("No", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => jurnalC.no = e,
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
                              hintText: "No",
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
                      Text("Volume", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => jurnalC.volume = e,
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
                              hintText: "Volume",
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
                      Text("Tahun", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => jurnalC.tahun = e,
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
                              hintText: "Tahun",
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
                      Text("Skema", style: TitleListText()),
                      Container(
                        width: 90.w,
                        height: 10.h,
                        child: DropdownButtonFormField<String>(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
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
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                          isExpanded: true,
                          hint: Text("Skema"),
                          items: [
                            DropdownMenuItem(
                              child: Text("Penelitian Dosen Pemula"),
                              value: "Penelitian Dosen Pemula",
                            ),
                            DropdownMenuItem(
                              child: Text("Penelitian Unggulan"),
                              value: "Penelitian Unggulan",
                            ),
                            DropdownMenuItem(
                              child: Text("Program Kemitraan Masyarakat"),
                              value: "Program Kemitraan Masyarakat",
                            ),
                            DropdownMenuItem(
                              child: Text("Program Bina Desa"),
                              value: "Program Bina Desa",
                            ),
                          ],
                          onChanged: (String value) {
                            jurnalC.skema = value;
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("Cover", style: TitleListText()),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: MyColor.primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 5, 15, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(() => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: jurnalC.cover.value.path != ""
                                      ? Image.file(
                                          jurnalC.cover.value,
                                          width: 30.w,
                                        )
                                      : Image.asset(
                                          "asset/image/logo_unh.png",
                                          width: 60.w,
                                        ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: IconButton(
                                onPressed: () => jurnalC.pickCover(),
                                icon: Icon(
                                  Icons.photo_library,
                                  color: MyColor.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("Abstrak", style: TitleListText()),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: MyColor.primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 5, 15, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(() => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: jurnalC.abstrak.value.path != ""
                                      ? Image.file(
                                          jurnalC.abstrak.value,
                                          width: 50.w,
                                          height: 20.h,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "asset/image/logo_unh.png",
                                          width: 50.w,
                                          height: 20.h,
                                        ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: IconButton(
                                onPressed: () => jurnalC.pickAbstrak(),
                                icon: Icon(
                                  Icons.photo_library,
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
