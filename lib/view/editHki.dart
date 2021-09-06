import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/hkiC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class EditHki extends StatelessWidget {
  // const AddJurnal({ Key? key }) : super(key: key);
  final hkiC = Get.put(HkiC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Edit HKI",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
        ),
        leading: InkWell(
          onTap: () {
            hkiC.file.value = File("");
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
                hkiC.editHki();
              },
              child: Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: LineIcon.edit(
                    color: MyColor.primaryColor,
                  ))),
        ],
      ),
      body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: hkiC.key,
                  child: Column(
                    children: [
                      Text("Judul Ciptaan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: hkiC.judulCiptaan,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 5,
                          onSaved: (e) => hkiC.judulCiptaan = e,
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
                              hintText: "Judul Ciptaan",
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
                          initialValue: hkiC.noPermohonan,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 2,
                          onSaved: (e) => hkiC.noPermohonan = e,
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
                      Text("Tgl Permohonan", style: TitleListText()),
                      InkWell(
                        onTap: () => hkiC.selectDate(
                            jenisTgl: "permohonan", context: context),
                        child: Container(
                          child: TextFormField(
                            // initialValue: hkiC.tglPermohonan,
                            controller: hkiC.dateController,
                            enabled: false,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            maxLines: 1,
                            onSaved: (e) => hkiC.tglPermohonan = e,
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
                                hintText: hkiC.tglPermohonan,
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
                      Text("Nama", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: hkiC.nama,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => hkiC.nama = e,
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
                        height: 10.h,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Text("Jenis Ciptaan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: hkiC.jenisCiptaan,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => hkiC.jenisCiptaan = e,
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
                              hintText: "Jenis Ciptaan",
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
                      Text("Tgl Diumumkan", style: TitleListText()),
                      InkWell(
                        onTap: () => hkiC.selectDate(
                            jenisTgl: "diumumkan", context: context),
                        child: Container(
                          child: TextFormField(
                            controller: hkiC.dateController2,
                            enabled: false,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null;
                            },
                            maxLines: 1,
                            onSaved: (e) => hkiC.tglDiumumkan = e,
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
                                hintText: hkiC.tglDiumumkan,
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
                      Text("Tempat Diumumkan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: hkiC.tempatDiumumkan,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => hkiC.tempatDiumumkan = e,
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
                              hintText: "Tempat Diumumkan",
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
                      Text("Jangka Waktu", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: hkiC.jangkaWaktu,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => hkiC.jangkaWaktu = e,
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
                              hintText: "Jangka Waktu",
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
                      Text("No Pencatatan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: hkiC.noPencatatan,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => hkiC.noPencatatan = e,
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
                              hintText: "No Pencatatan",
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
                                child: hkiC.fileTxt.value == ""
                                    ? hkiC.file.value.path == ""
                                        ? Center(
                                            child: Text(
                                            "File Name",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                        : Center(
                                            child: Text(
                                            hkiC.file.value.path
                                                .split('/')
                                                .last,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    : Center(
                                        child: Text(
                                        hkiC.fileTxt.value,
                                        style: TextStyle(color: Colors.white),
                                      )))),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: IconButton(
                                onPressed: () => hkiC.pickFile(),
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
