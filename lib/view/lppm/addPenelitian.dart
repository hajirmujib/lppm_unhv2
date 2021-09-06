import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:sizer/sizer.dart';

class AddPenelitian extends StatelessWidget {
  // const AddPenelitian({ Key? key }) : super(key: key);
  final penelitian = Get.put(PenelitianC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Penelitian"),
        actions: [
          IconButton(
            onPressed: () {
              penelitian.uploadPenelitian();
            },
            icon: LineIcon.plus(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Form(
                key: penelitian.key,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Judul"),
                      ),
                      Container(
                        width: 100.w,
                        height: 20.h,
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          initialValue: penelitian.judulPenelitian,
                          onSaved: (e) => penelitian.judulPenelitian = e,
                          maxLines: 5,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
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
                              hintText: "Judul",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Jenis"),
                      ),
                      Container(
                        width: 100.w,
                        height: 10.h,
                        child: DropdownButtonFormField<String>(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          value: penelitian.jenisDefault.value,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Penelitian"),
                              value: "penelitian",
                            ),
                            DropdownMenuItem(
                              child: Text("Pengabdian"),
                              value: "pengabdian",
                            ),
                          ],
                          onChanged: (String value) {
                            penelitian.jenis.value = value;
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Sumber Dana"),
                      ),
                      Container(
                        width: 100.w,
                        height: 10.h,
                        child: DropdownButtonFormField<String>(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Internal"),
                              value: "internal",
                            ),
                            DropdownMenuItem(
                              child: Text("Eksternal"),
                              value: "eksternal",
                            ),
                          ],
                          onChanged: (String value) {
                            penelitian.sumberDana.value = value;
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Dana Tersedia"),
                      ),
                      Container(
                        width: 100.w,
                        height: 20.h,
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          onSaved: (e) => penelitian.danaTersedia.value = e,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
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
                              hintText: "Dana Tersedia",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
