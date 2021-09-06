import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/model/PatenM.dart';
import 'package:lppm_unhv2/widget/dateText.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:lppm_unhv2/widget/whiteTitleText.dart';
import 'package:sizer/sizer.dart';

class DetailPaten extends StatelessWidget {
  // const DetailJurnal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Detail Paten",
          style: TextStyle(color: MyColor.primaryColor, fontSize: 18),
        ),
        centerTitle: true,
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
          DetailContainer(widthScreen: widthScreen, heightScreen: heightScreen),
          ContentContainer(widthScreen: widthScreen, heightScreen: heightScreen)
        ],
      )),
    );
  }
}

class ContentContainer extends StatelessWidget {
  ContentContainer({
    Key key,
    @required this.widthScreen,
    @required this.heightScreen,
  }) : super(key: key);

  final double widthScreen;
  final double heightScreen;
  final patenC = Get.put(PatenC());

  @override
  Widget build(BuildContext context) {
    final Paten x = patenC.patenById();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Pengajuan :",
                  style: TitleListText(),
                ),
                Text(
                  x.tglPengajuan.toString(),
                  style: DateText(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "No Permohonan :",
                  style: TitleListText(),
                ),
                Text(
                  x.noPermohonan,
                  style: DateText(),
                ),
              ],
            ),
            Text(
              "Pemohon :",
              style: TitleListText(),
            ),
            Text(
              x.pemohon ?? "",
              style: DateText(),
            ),
            Divider(color: Colors.grey),
            Text(
              "File :",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Poppins Regular",
                  fontWeight: FontWeight.w500),
            ),
            InkWell(
              onTap: () {
                DownloadfileC()
                    .requestDownload(link: x.file, jenis: "keluaran");
              },
              child: Text(
                x.file != "" ? x.file : "",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins Regular",
                    color: Colors.blue),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
        width: widthScreen,
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white),
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  DetailContainer({
    Key key,
    @required this.widthScreen,
    @required this.heightScreen,
  }) : super(key: key);

  final double widthScreen;
  final double heightScreen;
  final patenC = Get.put(PatenC());

  @override
  Widget build(BuildContext context) {
    final Paten x = patenC.patenById();
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: 80.h,
            child: Container(
              height: 70.h,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Text(
                  x.judulInvensi,
                  style: WhiteTitleText(),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                )),
              ),
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
        width: 100.h,
        height: 30.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: MyColor.primaryColor),
      ),
    );
  }
}
