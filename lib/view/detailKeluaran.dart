import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/bukuC.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/controller/hkiC.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/lainyaC.dart';
import 'package:lppm_unhv2/controller/launchUrl.dart';
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/BukuM.dart';
import 'package:lppm_unhv2/model/HkiM.dart';
import 'package:lppm_unhv2/model/LainyaM.dart';
import 'package:lppm_unhv2/model/PatenM.dart';
import 'package:lppm_unhv2/model/jurnalM.dart';
import 'package:lppm_unhv2/view/addBuku.dart';
import 'package:lppm_unhv2/view/addHki.dart';
import 'package:lppm_unhv2/view/addLainya.dart';
import 'package:lppm_unhv2/view/detailHki.dart';
import 'package:lppm_unhv2/view/detailJurnal.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:lppm_unhv2/widget/whiteTitleText.dart';
import 'package:sizer/sizer.dart';
import 'package:async/async.dart';

import 'addJurnal.dart';
import 'addPaten.dart';
import 'detailBuku.dart';
import 'detailLainya.dart';
import 'detailPaten.dart';

class DetailKeluaran extends StatelessWidget {
  // const DetailInfoView({ Key? key }) : super(key: key);

  final jurnalC = Get.put(JurnalC());
  final downloadC = Get.put(DownloadfileC());
  final userC = Get.put(UsersC());
  final AsyncMemoizer dCMemorizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Keluaran Hasil Penelitian",
            style: TextStyle(color: MyColor.primaryColor)),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: MyColor.primaryColor),
              child: Icon(Icons.arrow_back)),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Align(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    "",
                    style: WhiteTitleText(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                  color: MyColor.primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      "Jurnal",
                      style: TitleListText(),
                    ),
                    GetX<JurnalC>(
                      init: JurnalC(),
                      initState: (_) {},
                      builder: (jurnal) {
                        return FutureBuilder<Jurnal>(
                            future: jurnal.jurnalPenelitian(),
                            builder: (contex, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error:${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                Jurnal x = snapshot.data;
                                return Slidable(
                                  actionPane: SlidableBehindActionPane(),
                                  actions: [
                                    userC.idU.value == jurnal.idUser.value
                                        ? IconButton(
                                            onPressed: () {
                                              jurnal.showDialog(id: x.id);
                                            },
                                            icon: LineIcon.minusCircle(
                                              color: Colors.red,
                                              size: 5.h,
                                            ))
                                        : Text(""),
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      jurnalC.idJurnal.value = x.id;
                                      jurnalC.fetchJurnal();
                                      Get.to(() => DetailJurnal());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: 90.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: MyColor.primaryColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text("Link :"),
                                          ),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              LaunchUrl().launchURL(x.link);
                                            },
                                            child: Text(
                                              x.link != ""
                                                  ? x.link
                                                  : "Belum Ada Data",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Row(
                                    children: [
                                      userC.idU.value == jurnal.idUser.value
                                          ? Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddJurnal());
                                                  },
                                                  icon: LineIcon.plusCircle(
                                                    color: Colors.blue,
                                                    size: 5.h,
                                                  )),
                                            )
                                          : Text(""),
                                      Expanded(
                                          child: Center(
                                              child: Text("Belum Ada Data"))),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      "HKI",
                      style: TitleListText(),
                    ),
                    GetX<HkiC>(
                      init: HkiC(),
                      initState: (_) {},
                      builder: (hki) {
                        return FutureBuilder<HKI>(
                            future: hki.hkiPenelitian(),
                            builder: (contex, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error:${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                HKI x = snapshot.data;
                                return Slidable(
                                  actionPane: SlidableBehindActionPane(),
                                  actions: [
                                    userC.idU.value == hki.idUser.value
                                        ? IconButton(
                                            onPressed: () {
                                              hki.showDialog(id: x.id);
                                            },
                                            icon: LineIcon.minusCircle(
                                              color: Colors.red,
                                              size: 5.h,
                                            ))
                                        : Text(""),
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      hki.idHki.value = x.id;
                                      hki.fetchHki();
                                      Get.to(() => DetailHki());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: 90.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: MyColor.primaryColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text("File Hki :"),
                                          ),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              DownloadfileC().requestDownload(
                                                  link: x.file,
                                                  jenis: "keluaran");
                                            },
                                            child: Text(
                                              x.file != ""
                                                  ? x.file
                                                  : "Belum Ada Data",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Row(
                                    children: [
                                      userC.idU.value == hki.idUser.value
                                          ? Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddHki());
                                                  },
                                                  icon: LineIcon.plusCircle(
                                                    color: Colors.blue,
                                                    size: 5.h,
                                                  )),
                                            )
                                          : Text(""),
                                      Expanded(
                                          child: Center(
                                              child: Text("Belum Ada Data"))),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      "Paten",
                      style: TitleListText(),
                    ),
                    GetX<PatenC>(
                      init: PatenC(),
                      initState: (_) {},
                      builder: (paten) {
                        return FutureBuilder<Paten>(
                            future: paten.patenPenelitian(),
                            builder: (contex, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error:${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                Paten x = snapshot.data;
                                return InkWell(
                                  onTap: () {},
                                  child: Slidable(
                                    actionPane: SlidableBehindActionPane(),
                                    actions: [
                                      userC.idU.value == paten.idUser.value
                                          ? IconButton(
                                              onPressed: () {
                                                paten.showDialog(id: x.id);
                                              },
                                              icon: LineIcon.minusCircle(
                                                color: Colors.red,
                                                size: 5.h,
                                              ))
                                          : Text(""),
                                    ],
                                    child: InkWell(
                                      onTap: () {
                                        paten.idPaten.value = x.id;
                                        paten.fethPaten();
                                        Get.to(() => DetailPaten());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        width: 90.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColor.primaryColor),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text("File Paten :"),
                                            ),
                                            Expanded(
                                                child: InkWell(
                                              onTap: () {
                                                DownloadfileC().requestDownload(
                                                    link: x.file,
                                                    jenis: "keluaran");
                                              },
                                              child: Text(
                                                x.file != ""
                                                    ? x.file
                                                    : "Belum Ada Data",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                softWrap: true,
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Row(
                                    children: [
                                      userC.idU.value == paten.idUser.value
                                          ? Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddPaten());
                                                  },
                                                  icon: LineIcon.plusCircle(
                                                    color: Colors.blue,
                                                    size: 5.h,
                                                  )),
                                            )
                                          : Text(""),
                                      Expanded(
                                          child: Center(
                                              child: Text("Belum Ada Data"))),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      "Buku",
                      style: TitleListText(),
                    ),
                    GetX<BukuC>(
                      init: BukuC(),
                      initState: (_) {},
                      builder: (buku) {
                        return FutureBuilder<Buku>(
                            future: buku.bukuPenelitian(),
                            builder: (contex, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error:${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                Buku x = snapshot.data;
                                return Slidable(
                                  actionPane: SlidableBehindActionPane(),
                                  actions: [
                                    userC.idU.value == buku.idUser.value
                                        ? IconButton(
                                            onPressed: () {
                                              buku.showDialog(id: x.id);
                                            },
                                            icon: LineIcon.minusCircle(
                                              color: Colors.red,
                                              size: 5.h,
                                            ))
                                        : Text(""),
                                    IconButton(
                                        onPressed: () {
                                          buku.showDialog(id: x.id);
                                        },
                                        icon: LineIcon.minusCircle(
                                          color: Colors.red,
                                          size: 5.h,
                                        ))
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      buku.idBuku.value = x.id;
                                      buku.fetchBuku();
                                      Get.to(() => DetailBuku());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: 90.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: MyColor.primaryColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text("File Buku :"),
                                          ),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              DownloadfileC().requestDownload(
                                                  link: x.file,
                                                  jenis: "keluaran");
                                            },
                                            child: Text(
                                              x.file != ""
                                                  ? x.file
                                                  : "Belum Ada Data",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Row(
                                    children: [
                                      userC.idU.value == buku.idUser.value
                                          ? Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddBuku());
                                                  },
                                                  icon: LineIcon.plusCircle(
                                                    color: Colors.blue,
                                                    size: 5.h,
                                                  )),
                                            )
                                          : Text(""),
                                      Expanded(
                                          child: Center(
                                              child: Text("Belum Ada Data"))),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      "Lainya",
                      style: TitleListText(),
                    ),
                    GetX<LainnyaC>(
                      init: LainnyaC(),
                      initState: (_) {},
                      builder: (lainya) {
                        return FutureBuilder<Lainya>(
                            future: lainya.lainyaPenelitian(),
                            builder: (contex, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error:${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                Lainya x = snapshot.data;
                                return Slidable(
                                  actionPane: SlidableBehindActionPane(),
                                  actions: [
                                    userC.idU.value == lainya.idUser.value
                                        ? IconButton(
                                            onPressed: () {
                                              lainya.showDialog(id: x.id);
                                            },
                                            icon: LineIcon.minusCircle(
                                              color: Colors.red,
                                              size: 5.h,
                                            ))
                                        : Text(""),
                                    IconButton(
                                        onPressed: () {
                                          lainya.showDialog(id: x.id);
                                        },
                                        icon: LineIcon.minusCircle(
                                          color: Colors.red,
                                          size: 5.h,
                                        ))
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      lainya.idLainya.value = x.id;
                                      lainya.fethLainya();
                                      Get.to(() => DetailLainya());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: 90.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: MyColor.primaryColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text("File Lainya :"),
                                          ),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              DownloadfileC().requestDownload(
                                                  link: x.file,
                                                  jenis: "keluaran");
                                            },
                                            child: Text(
                                              x.file != ""
                                                  ? x.file
                                                  : "Belum Ada Data",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Row(
                                    children: [
                                      userC.idU.value == lainya.idUser.value
                                          ? Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddLainya());
                                                  },
                                                  icon: LineIcon.plusCircle(
                                                    color: Colors.blue,
                                                    size: 5.h,
                                                  )),
                                            )
                                          : Text(""),
                                      Expanded(
                                          child: Center(
                                              child: Text("Belum Ada Data"))),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              padding: EdgeInsets.fromLTRB(5, 30, 5, 5),
              width: 100.w,
              height: 80.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            ),
          )
        ],
      )),
    );
  }
}
