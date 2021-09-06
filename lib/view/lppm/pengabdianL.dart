import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/pengabdianC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/widget/itemTahun.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class PengabdianL extends StatelessWidget {
  final komentarProposal = Get.put(KomentarProposalC());
  final pengabdianC = Get.put(PengabdianC());
  final penelitianC = Get.put(PenelitianC());
  final jurnalC = Get.put(JurnalC());
  final optionLaporanC = Get.put(OptionLaporan());
  final userC = Get.put(UsersC());

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
              "Pengabdian",
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
                        // pengabdianC.fetchPenelitian();
                        // ExcelPenelitian().createExcel();
                        optionLaporanC.dropDownMenuTahunPenelitian =
                            optionLaporanC.getDropDownMenuTahunPengabdian();
                        optionLaporanC.jenis.value = "Pengabdian";
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
            onRefresh: pengabdianC.getTahunInternal,
            child: Obx(() {
              if (pengabdianC.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (pengabdianC.listTahunInternal.isEmpty) {
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
                      itemCount: pengabdianC.listTahunInternal.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var x = pengabdianC.listTahunInternal[i];
                        return InkWell(
                          onTap: () {
                            penelitianC.sumberDana.value = 'internal';
                            pengabdianC.sumberDana.value = 'internal';
                            pengabdianC.tahun.value = x.tahun;
                            pengabdianC.getPengabdianInternal();
                            pengabdianC.optionPenelitian();
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
            onRefresh: pengabdianC.getTahunEksternal,
            child: Obx(() {
              if (pengabdianC.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (pengabdianC.listTahunEksternal.isEmpty) {
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
                      itemCount: pengabdianC.listTahunEksternal.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var x = pengabdianC.listTahunEksternal[i];
                        return InkWell(
                          onTap: () {
                            penelitianC.sumberDana.value = 'eksternal';
                            pengabdianC.sumberDana.value = 'eksternal';
                            pengabdianC.tahun.value = x.tahun;
                            pengabdianC.tahun.value = x.tahun;
                            pengabdianC.getPengabdianEksternal();
                            pengabdianC.optionPenelitian();
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
