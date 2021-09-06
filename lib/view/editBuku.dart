import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/bukuC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class EditBuku extends StatelessWidget {
  // const AddJurnal({ Key? key }) : super(key: key);
  final bukuC = Get.put(BukuC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Edit Buku",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
        ),
        leading: InkWell(
          onTap: () {
            bukuC.file.value = File("");
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
                bukuC.editBuku();
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: LineIcon.edit(color: MyColor.primaryColor),
              )),
        ],
      ),
      body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: bukuC.key,
                  child: Column(
                    children: [
                      Text("Judul Buku", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: bukuC.judul,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 5,
                          onSaved: (e) => bukuC.judul = e,
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
                              hintText: "Judul Buku",
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
                      Text("Pengarang", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: bukuC.pengarang,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 2,
                          onSaved: (e) => bukuC.pengarang = e,
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
                              hintText: "Pengarang",
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
                      Text("Penerbit", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: bukuC.penerbit,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => bukuC.penerbit = e,
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
                              hintText: "Penerbit",
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
                      Text("Tahun Penerbit", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: bukuC.tahunTerbit,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => bukuC.tahunTerbit = e,
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
                              hintText: "Tahun Terbit",
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
                      Text("Ketebalan", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: bukuC.ketebalan,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => bukuC.ketebalan = e,
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
                              hintText: "Ketebalan",
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
                      Text("No Edisi", style: TitleListText()),
                      Container(
                        child: TextFormField(
                          initialValue: bukuC.noEdisi,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          maxLines: 1,
                          onSaved: (e) => bukuC.noEdisi = e,
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
                              hintText: "No Edisi",
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
                                child: bukuC.fileTxt.value == ""
                                    ? bukuC.file.value.path == ""
                                        ? Center(
                                            child: Text(
                                            "File Name",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                        : Center(
                                            child: Text(
                                            bukuC.file.value.path
                                                .split('/')
                                                .last,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    : Center(
                                        child: Text(
                                        bukuC.fileTxt.value,
                                        style: TextStyle(color: Colors.white),
                                      )))),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: IconButton(
                                onPressed: () => bukuC.pickFile(),
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
