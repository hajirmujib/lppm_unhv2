import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/catatanHarianC.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/controller/komentarPenelitianC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/pengabdianC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/catatanModel.dart';
import 'package:lppm_unhv2/model/komentarPenelitianM.dart';
import 'package:lppm_unhv2/model/penelitianM.dart';
import 'package:lppm_unhv2/widget/detailTextWhite.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/whiteTitleText.dart';
import 'package:sizer/sizer.dart';

class DetailCatatanHarian extends StatelessWidget {
  // const DetailProposal({ Key? key }) : super(key: key);
  final downloadC = Get.put(DownloadfileC());
  final userC = Get.put(UsersC());
  final komentar = Get.put(KomentarPenelitianC());
  final penelitianC = Get.put(PenelitianC());
  final pengabdianC = Get.put(PengabdianC());
  final catatanC = Get.put(CatatanHarianC());

  @override
  Widget build(BuildContext context) {
    // final UsulanProposal proposal = proposalC.proposalById();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Detail Catatan Harian",
          style: TextStyle(
            color: MyColor.primaryColor,
          ),
        ),
        leading: InkWell(
          onTap: () {
            penelitianC.idPenelitian.value = "";
            penelitianC.hTopContainer.value = 15.h;
            penelitianC.catatanContainer.value = 8.h;
            penelitianC.visibility(false);
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
          userC.levelU.value == "lppm"
              ? InkWell(
                  onTap: () {
                    penelitianC.editStatus();
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyColor.primaryColor),
                      child: LineIcon.checkCircle()),
                )
              : Text(""),
          InkWell(
            onTap: () async {
              if (userC.idU.value == penelitianC.idUser.value) {
                penelitianC.editJudul();
              } else {
                penelitianC.editDanaTersedia();
              }
            },
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: LineIcon.edit()),
          ),
          userC.idU.value == penelitianC.idUser.value
              ? InkWell(
                  onTap: () async {
                    penelitianC.editDanaTerpakai();
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyColor.primaryColor),
                      child: LineIcon.wavyMoneyBill()),
                )
              : Text(""),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Obx(
            () {
              if (penelitianC.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return FutureBuilder(
                  future: catatanC.jenis.value == "Penelitian"
                      ? penelitianC.penelitianById()
                      : pengabdianC.pengabdianById(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Penelitian penelitian = snapshot.data;
                      return Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 20.h,
                                    maxHeight: 30.h,
                                  ),
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        penelitian.judul ?? "",
                                        style: WhiteTitleText(),
                                        textAlign: TextAlign.center,
                                        maxLines: penelitianC.maxLine,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Tanggal : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + penelitian.tanggal.toString(),
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Dosen : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + penelitian.nama ?? "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Dana Tersedia : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": Rp. " + penelitian.danaTersedia ??
                                            "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Dana Terpakai : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": Rp. " + penelitian.danaTerpakai ??
                                            "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Status",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + penelitian.status ?? "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.white),
                              ],
                            ),
                            width: 100.w,
                            height: 75.h,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                            decoration: BoxDecoration(
                                color: MyColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            },
          ),
          Obx(() => Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: IconButton(
                            icon: penelitianC.isUp.value == true
                                ? LineIcon.arrowCircleUp()
                                : LineIcon.arrowCircleDown(),
                            onPressed: () {
                              penelitianC.setHtopContainer();
                              penelitianC.setUp();
                              penelitianC.setVisibel();
                            },
                          ),
                        ),
                        Container(
                            width: 90.w,
                            height: 10.h,
                            child: Form(
                              key: komentar.key,
                              child: TextFormField(
                                controller: komentar.komentarTxt,
                                onSaved: komentar.isi,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18),
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
                                    hintText: "Komentar",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: InkWell(
                                        onTap: () {
                                          komentar.uploadKomentar();
                                        },
                                        child: LineIcon.arrowCircleLeft()),
                                    fillColor: Colors.white,
                                    filled: true),
                              ),
                            )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Obx(() {
                          if (komentar.isLoading.value == true) {
                            return Center(child: CircularProgressIndicator());
                          } else if (komentar.komentarList.length == 0) {
                            return Center(
                              child: Text("Belum Ada Komentar"),
                            );
                          }
                          return Visibility(
                            visible: penelitianC.visibility.value,
                            child: AnimatedContainer(
                              padding: EdgeInsets.only(bottom: 10),
                              duration: Duration(milliseconds: 500),
                              height: 55.h,
                              width: 100.h,
                              child: ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: komentar.komentarList.length ?? 0,
                                itemBuilder: (context, int i) {
                                  KomentarPenelitian x =
                                      komentar.komentarList[i];
                                  return Slidable(
                                    enabled: userC.idU.value == x.idUsers
                                        ? true
                                        : false,
                                    actionPane: SlidableDrawerActionPane(),
                                    actions: [
                                      InkWell(
                                          onTap: () => komentar.showDialog(
                                              id: x.idKomentar),
                                          child: Icon(LineIcons.trash,
                                              color: Colors.red)),
                                      InkWell(
                                          onTap: () => komentar.showEdit(
                                              id: x.idKomentar,
                                              isi: x.isi ?? ""),
                                          child: Icon(LineIcons.edit,
                                              color: Colors.blue)),
                                    ],
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.indigo,
                                            child: Text(x.nama[0] + x.nama[1]),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(x.nama),
                                                Text(x.tanggal.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                Divider(color: Colors.black),
                                                Text(
                                                  x.isi ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: 100.w,
                  height: penelitianC.hTopContainer.value,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
              )),
          Obx(() => Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: IconButton(
                            icon: penelitianC.catatanIsUp.value == true
                                ? LineIcon.arrowCircleUp()
                                : LineIcon.arrowCircleDown(),
                            onPressed: () {
                              penelitianC.setCatatanContainer();
                              penelitianC.setCatatanUp();
                              penelitianC.setVisibelCatatan();
                            },
                          ),
                        ),
                        Container(
                            width: 90.w,
                            height: 30.h,
                            child: Column(
                              children: [
                                Form(
                                  key: catatanC.key,
                                  child: TextFormField(
                                    controller: catatanC.catatanTxt,
                                    onSaved: catatanC.keterangan,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                    decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.indigo)),
                                        hintText: "Keterangan",
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                        fillColor: Colors.white,
                                        filled: true),
                                  ),
                                ),
                                Row(children: [
                                  IconButton(
                                      icon: Icon(Icons.attach_file),
                                      onPressed: () {
                                        catatanC.pickFile();
                                      }),
                                  Expanded(
                                    child: catatanC.file.value.path == ""
                                        ? Text("File Name")
                                        : Text(
                                            catatanC.file.value.path
                                                .split('/')
                                                .last,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false),
                                  ),
                                  catatanC.file.value.path != ""
                                      ? IconButton(
                                          onPressed: () {
                                            catatanC.file.value = File("");
                                            catatanC.file.value.path
                                                .removeAllWhitespace;
                                          },
                                          icon: LineIcon.minusCircle())
                                      : Text(""),
                                ]),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      catatanC.idUser.value == userC.idU.value
                                          ? catatanC.addCatatan()
                                          : penelitianC
                                              .showToast("Tidak Ada Acces");
                                    },
                                    icon: LineIcon.arrowCircleLeft(),
                                    label: Text("Kirim"))
                              ],
                            )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Obx(() {
                          if (catatanC.isLoading.value == true) {
                            return Center(child: CircularProgressIndicator());
                          } else if (catatanC.listCatatan.length == 0) {
                            return Center(
                              child: Text("Belum Ada Catatan"),
                            );
                          }
                          return Visibility(
                            visible: penelitianC.catatanVisibility.value,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height: 55.h,
                              width: 100.h,
                              child: RefreshIndicator(
                                onRefresh: () {
                                  return catatanC.catatanById();
                                },
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    itemCount: catatanC.listCatatan.length ?? 0,
                                    itemBuilder: (context, i) {
                                      CatatanHarian x = catatanC.listCatatan[i];
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              x.idUser == userC.idU.value
                                                  ? catatanC.deleteCatatan(
                                                      id: x.idFile)
                                                  : penelitianC.showToast(
                                                      "Tidak Ada Acces");
                                            },
                                            icon: LineIcon.trash(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      MyColor.secondaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: 80.w,
                                          height: 25.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Text("Keterangan")),
                                              Expanded(
                                                  child: Text(
                                                x.keterangan,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: false,
                                              )),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text("Tanggal")),
                                                  Expanded(
                                                      child: Text(
                                                    ": " + x.tanggal.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: false,
                                                  )),
                                                ],
                                              ),
                                              Divider(color: Colors.grey),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: InkWell(
                                                          onTap: () {
                                                            downloadC
                                                                .requestDownload(
                                                                    link:
                                                                        x.file,
                                                                    jenis:
                                                                        "fileKegiatan");
                                                          },
                                                          child:
                                                              LineIcon.file())),
                                                  Expanded(
                                                      child: Text(
                                                    ": " + x.file,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: false,
                                                  )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: 100.w,
                  height: penelitianC.catatanContainer.value,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColor.primaryColor),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
              ))
        ],
      )),
    );
  }
}
