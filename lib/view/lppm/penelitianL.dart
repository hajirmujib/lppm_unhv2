import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/widget/itemTahun.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class PenelitianL extends StatelessWidget {
  final userC = Get.put(UsersC());
  final komentarProposal = Get.put(KomentarProposalC());
  final penelitianC = Get.put(PenelitianC());
  final jurnalC = Get.put(JurnalC());
  final optionLaporanC = Get.put(OptionLaporan());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColor.primaryColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Penelitian",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Poppin", fontSize: 15),
              maxLines: 3,
            ),
            leading: InkWell(
              onTap: () => Get.back(),
              child: Container(
                  width: 20,
                  height: 2,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: MyColor.primaryColor,
                  )),
            ),
            actions: [
              userC.levelU.value == "lppm"
                  ? InkWell(
                      onTap: () {
                        // penelitianC.fetchPenelitian();
                        // ExcelPenelitian().createExcel();
                        optionLaporanC.dropDownMenuTahunPenelitian =
                            optionLaporanC.getDropDownMenuTahunPenelitian();
                        optionLaporanC.jenis.value = "Penelitian";
                        optionLaporanC.showDialog();
                      },
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: LineIcon.book(
                          size: 20,
                          color: MyColor.primaryColor,
                        ),
                      ),
                    )
                  : Text(""),
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "Internal",
              ),
              Tab(
                text: "Eksternal",
              ),
            ])),
        body: SafeArea(
            child: TabBarView(children: [
          RefreshIndicator(
            onRefresh: penelitianC.getTahunInternal,
            child: Obx(() {
              if (penelitianC.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (penelitianC.listTahunInternal.isEmpty) {
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      width: 80.w,
                      height: 30.h,
                      child: Center(
                        child: Text("Data Belum Ada"),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 100.w,
                  height: 100.h,
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: penelitianC.listTahunInternal.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var x = penelitianC.listTahunInternal[i];
                        return InkWell(
                          onTap: () {
                            penelitianC.sumberDana.value = 'internal';
                            penelitianC.tahun.value = x.tahun;
                            penelitianC.getPenelitianInternal();
                            penelitianC.optionPenelitian();

                            jurnalC.sumberDana.value = 'internal';
                            jurnalC.tahunPenelitian.value = x.tahun;
                          },
                          child: ItemTahun(tahun: x.tahun),
                        );
                      }),
                );
              }
            }),
          ),
          RefreshIndicator(
            onRefresh: penelitianC.getTahunEksternal,
            child: Obx(() {
              if (penelitianC.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (penelitianC.listTahunEksternal.isEmpty) {
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      width: 80.w,
                      height: 30.h,
                      child: Center(
                        child: Text("Data Belum Ada"),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 100.w,
                  height: 100.h,
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: penelitianC.listTahunEksternal.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var x = penelitianC.listTahunEksternal[i];
                        return InkWell(
                          onTap: () {
                            penelitianC.sumberDana.value = 'eksternal';
                            penelitianC.tahun.value = x.tahun;
                            penelitianC.tahun.value = x.tahun;
                            penelitianC.getPenelitianEksternal();
                            penelitianC.optionPenelitian();
                            jurnalC.sumberDana.value = 'eksternal';
                            jurnalC.tahunPenelitian.value = x.tahun;
                          },
                          child: ItemTahun(tahun: x.tahun),
                        );
                      }),
                );
              }
            }),
          ),
        ])),
      ),
    );
  }
}
