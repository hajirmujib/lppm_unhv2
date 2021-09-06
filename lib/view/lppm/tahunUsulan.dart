import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/tahunUsulanC.dart';
import 'package:lppm_unhv2/model/tahunUsulanM.dart';
import 'package:sizer/sizer.dart';

class TahunUsulanV extends StatelessWidget {
  // const TahunUsulanV({ Key? key }) : super(key: key);
  final tahunUsulan = Get.put(TahunUsulanC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Tahun Usulan"),
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Buka Usulan Baru", style: TextStyle(fontSize: 18)),
              Container(
                width: 100.w,
                height: 20.h,
                child: Column(
                  children: [
                    Form(
                      key: tahunUsulan.key,
                      child: TextFormField(
                        controller: tahunUsulan.tahunTxt,
                        onSaved: (e) => tahunUsulan.tahun = e,
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
                            hintText: "Tahun (ex:2021)",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (tahunUsulan.tahunList.length == 0) {
                            tahunUsulan.addTahun();
                          } else {
                            tahunUsulan.shotToast("Tahun Usulan Masih Terbuka");
                          }
                        },
                        icon: LineIcon.plus(),
                        label: Text("Buka")),
                  ],
                ),
              ),
              Text("Tahun Usulan Terbuka", style: TextStyle(fontSize: 18)),
              Container(
                width: 100.w,
                height: 50.h,
                child: Obx(() {
                  if (tahunUsulan.tahunList.length == 0) {
                    return Center(
                        child: Text("Tidak Ada Tahun Usulan Terbuka"));
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tahunUsulan.tahunList.length ?? 0,
                      itemBuilder: (context, int i) {
                        Tahun x = tahunUsulan.tahunList[i];
                        return Column(
                          children: [
                            Table(
                              defaultColumnWidth: FlexColumnWidth(2.0),
                              border: TableBorder.all(color: Colors.indigo),
                              children: [
                                TableRow(
                                  children: [
                                    Center(
                                        child: Text("Tahun",
                                            style: TextStyle(fontSize: 18))),
                                    Center(
                                        child: Text("Status",
                                            style: TextStyle(fontSize: 18)))
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Center(
                                        child: Text(x.tahun,
                                            style: TextStyle(fontSize: 18))),
                                    Center(
                                        child: Text(x.status,
                                            style: TextStyle(fontSize: 18)))
                                  ],
                                )
                              ],
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  tahunUsulan.editTahun(
                                    id: x.id,
                                    tahun: x.tahun,
                                  );
                                },
                                icon: LineIcon.lock(),
                                label: Text("Tutup")),
                          ],
                        );
                      });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
