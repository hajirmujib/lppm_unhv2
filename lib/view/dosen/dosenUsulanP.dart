import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/tahunUsulanC.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/view/addProposal.dart';
import 'package:lppm_unhv2/view/dosen/proposalPenelitian.dart';
import 'package:lppm_unhv2/view/dosen/proposalPengabdian.dart';
import 'package:lppm_unhv2/widget/itemTahun.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class DosenUsulanProposal extends StatelessWidget {
  // const LppmUsulanProposal({Key key}) : super(key: key);
  final uProposal = Get.put(UsulanProposalC());
  final komentarProposal = Get.put(KomentarProposalC());
  final penelitian = Get.put(PenelitianC());
  final tahunList = Get.put(TahunUsulanC());
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
              "Usulan Proposal",
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
              Obx(
                () => tahunList.tahunList.isEmpty
                    ? Text("")
                    : InkWell(
                        onTap: () {
                          Get.to(() => AddProposal());
                        },
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: LineIcon.plus(
                            size: 20,
                            color: MyColor.primaryColor,
                          ),
                        ),
                      ),
              ),
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "Penelitian",
              ),
              Tab(
                text: "Pengabdian",
              ),
            ])),
        body: SafeArea(
            child: TabBarView(children: [
          RefreshIndicator(
            onRefresh: uProposal.dosenTahunPenelitian,
            child: Obx(() {
              if (uProposal.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (uProposal.listTahunPenelitian.isEmpty) {
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
                      itemCount: uProposal.listTahunPenelitian.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var x = uProposal.listTahunPenelitian[i];
                        return InkWell(
                          onTap: () {
                            uProposal.tahunPenelitian.value = x.tahun;
                            uProposal.dosenPenelitian();
                            Get.to(
                              () => ProposalPenelitianD(),
                              transition: Transition.leftToRight,
                            );
                          },
                          child: ItemTahun(tahun: x.tahun),
                        );
                      }),
                );
              }
            }),
          ),
          RefreshIndicator(
            onRefresh: uProposal.dosenTahunPengabdian,
            child: Obx(() {
              if (uProposal.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (uProposal.listTahunPengabdian.isEmpty) {
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
                      itemCount: uProposal.listTahunPengabdian.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var x = uProposal.listTahunPengabdian[i];
                        return InkWell(
                          onTap: () {
                            uProposal.tahunPengabdian.value = x.tahun;
                            uProposal.dosenPengabdian();
                            Get.to(
                              () => ProposalPengabdianD(),
                              transition: Transition.leftToRight,
                            );
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
