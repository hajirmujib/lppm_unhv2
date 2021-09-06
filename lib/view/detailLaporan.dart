import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/controller/laporanC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/laporanM.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:lppm_unhv2/widget/whiteTitleText.dart';
import 'package:sizer/sizer.dart';
import 'package:async/async.dart';

class DetailLaporan extends StatelessWidget {
  // const DetailInfoView({ Key? key }) : super(key: key);

  final laporanC = Get.put(LaporanC());
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
        title: Text("Laporan", style: TextStyle(color: MyColor.primaryColor)),
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
                    "info.infoJudul",
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
              child: Column(
                children: [
                  Text(
                    "Laporan Kemajuan",
                    style: TitleListText(),
                  ),
                  GetX<LaporanC>(
                    init: LaporanC(),
                    initState: (_) {},
                    builder: (laporan) {
                      return FutureBuilder<Laporan>(
                          future: laporan.laporanKemajuanById(),
                          builder: (contex, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error:${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              Laporan x = snapshot.data;
                              return Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actions: [
                                  userC.idU.value == laporanC.idUser.value
                                      ? IconButton(
                                          onPressed: () {
                                            laporanC.showDialog(id: x.id);
                                          },
                                          icon: LineIcon.minusCircle(
                                            color: Colors.red,
                                            size: 5.h,
                                          ))
                                      : Text(""),
                                ],
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: 90.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: MyColor.primaryColor),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      downloadC.requestDownload(
                                          link: x.file, jenis: "keluaran");
                                    },
                                    child: Center(
                                      child: Text(
                                        x.file != ""
                                            ? x.file
                                            : "Belum Ada Laporan",
                                        style: TextStyle(color: Colors.blue),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Row(
                                  children: [
                                    userC.idU.value == laporanC.idUser.value
                                        ? Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  laporanC.formAdd(
                                                      jenisLaporan: "kemajuan");
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
                    "Laporan Akhir",
                    style: TitleListText(),
                  ),
                  Obx(() {
                    return FutureBuilder<Laporan>(
                        future: laporanC.laporanAkhirById(),
                        builder: (contex, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error :${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            Laporan x = snapshot.data;
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actions: [
                                userC.idU.value == laporanC.idUser.value
                                    ? IconButton(
                                        onPressed: () {
                                          laporanC.showDialog(id: x.id);
                                        },
                                        icon: LineIcon.minusCircle(
                                          color: Colors.red,
                                          size: 5.h,
                                        ))
                                    : Text(""),
                              ],
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: 90.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: MyColor.primaryColor),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    downloadC.requestDownload(
                                        link: x.file, jenis: "keluaran");
                                  },
                                  child: Center(
                                    child: Text(
                                      x.file.toString() != null
                                          ? x.file
                                          : "Belum Ada Laporan",
                                      style: TextStyle(color: Colors.blue),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  userC.idU.value == laporanC.idUser.value
                                      ? Expanded(
                                          child: IconButton(
                                              onPressed: () {
                                                laporanC.formAdd(
                                                    jenisLaporan: "akhir");
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
                  }),
                ],
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
