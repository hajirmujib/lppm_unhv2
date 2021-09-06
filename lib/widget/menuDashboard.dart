import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/catatanHarianC.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/pengabdianC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/view/dosen/dosenUsulanP.dart';
import 'package:lppm_unhv2/view/jurnalD.dart';
import 'package:lppm_unhv2/view/lppm/bukuL.dart';
import 'package:lppm_unhv2/view/lppm/hkiL.dart';
import 'package:lppm_unhv2/view/lppm/jurnalL.dart';
import 'package:lppm_unhv2/view/lppm/lainyaL.dart';
import 'package:lppm_unhv2/view/lppm/patenL.dart';
import 'package:lppm_unhv2/view/lppm/penelitianL.dart';
import 'package:lppm_unhv2/view/lppm/pengabdianL.dart';
import 'package:lppm_unhv2/view/lppm/usulanProposal.dart';
import 'package:sizer/sizer.dart';

class ContainerBottom extends StatelessWidget {
  final UsulanProposalC uProposal = Get.put(UsulanProposalC());
  final penelitianC = Get.put(PenelitianC());
  final pengabdianC = Get.put(PengabdianC());
  final catatanC = Get.put(CatatanHarianC());
  final userC = Get.put(UsersC());
  final jurnalC = Get.put(JurnalC());
  ContainerBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 4,
          children: [
            InkWell(
              onTap: () {
                if (userC.levelU.value == "lppm") {
                  uProposal.lppmUsulanProposal();
                  Get.to(() => LppmUsulanProposal());
                } else {
                  uProposal.dosenTahunPenelitian();
                  uProposal.dosenTahunPengabdian();
                  Get.to(() => DosenUsulanProposal());
                }
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: Colors.red,
                    ),
                    Text(
                      "Usulan \n Proposal",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                penelitianC.getTahunEksternal();
                penelitianC.getTahunInternal();
                catatanC.jenis.value = "Penelitian";
                Get.to(() => PenelitianL());
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book,
                      color: Colors.purple,
                    ),
                    Text(
                      "Penelitian",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                catatanC.jenis.value = "Pengabdian";
                pengabdianC.getTahunEksternal();
                pengabdianC.getTahunInternal();
                Get.to(() => PengabdianL());
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_pin_circle_rounded,
                      color: Colors.blue,
                    ),
                    Text(
                      "Pengabdian",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                if (userC.levelU.value == "lppm") {
                  Get.to(() => JurnalLppm());
                } else {
                  jurnalC.fetchJurnalDosen();
                  Get.to(() => JurnalD());
                }
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_sharp,
                      color: Colors.green,
                    ),
                    Text(
                      "Jurnal",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => PatenLppm());
                // if (userC.levelU.value == "lppm") {
                //   Get.to(() => PatenLppm());
                // } else {
                //   // uProposal.dosenTahunPenelitian();
                //   // uProposal.dosenTahunPengabdian();
                //   // Get.to(() => ListJurnalView());
                // }
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.amber,
                    ),
                    Text(
                      "Paten",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => HkiLppm());
                // if (userC.levelU.value == "lppm") {
                //   Get.to(() => HkiLppm());
                // } else {
                // uProposal.dosenTahunPenelitian();
                // uProposal.dosenTahunPengabdian();
                // Get.to(() => ListJurnalView());
                // }
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      color: Colors.blueAccent,
                    ),
                    Text(
                      "HKI",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => BukuLppm());

                // if (userC.levelU.value == "lppm") {
                //   Get.to(() => BukuLppm());
                // } else {
                // uProposal.dosenTahunPenelitian();
                // uProposal.dosenTahunPengabdian();
                // Get.to(() => ListJurnalView());
                // }
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.library_books,
                      color: Colors.orange,
                    ),
                    Text(
                      "Buku",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => LainyaLppm());

                // if (userC.levelU.value == "lppm") {
                //   Get.to(() => LainyaLppm());
                // } else {
                // uProposal.dosenTahunPenelitian();
                // uProposal.dosenTahunPengabdian();
                // Get.to(() => ListJurnalView());
                // }
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.more,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Lainya",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppin Regular"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        width: 100.w,
        height: 33.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      ),
    );
  }
}
