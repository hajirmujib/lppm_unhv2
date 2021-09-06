import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/bukuC.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/model/BukuM.dart';
import 'package:lppm_unhv2/widget/contentJurnalText.dart';
import 'package:lppm_unhv2/widget/detailJurnalText.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class DetailBuku extends StatelessWidget {
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
          "Detail Buku",
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
  final bukuC = Get.put(BukuC());

  @override
  Widget build(BuildContext context) {
    final Buku x = bukuC.bukuById();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Text(
                x.judul,
                style: TitleListText(),
                textAlign: TextAlign.center,
              )),
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
        height: 30.h,
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
  final bukuC = Get.put(BukuC());

  @override
  Widget build(BuildContext context) {
    final Buku x = bukuC.bukuById();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Pengarang :",
                        style: DetailJurnalText(),
                      ),
                      Text(
                        x.pengarang,
                        style: ContentJurnalText(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Penerbit :",
                        style: DetailJurnalText(),
                      ),
                      Text(
                        x.penerbit,
                        style: ContentJurnalText(),
                      ),
                    ],
                  ),
                  Text(
                    "Ketebalan :",
                    style: DetailJurnalText(),
                  ),
                  Text(
                    x.ketebalan ?? "",
                    style: ContentJurnalText(),
                  ),
                  Text(
                    "Tahun Terbit :",
                    style: DetailJurnalText(),
                  ),
                  Text(
                    x.tahunTerbit,
                    style: ContentJurnalText(),
                  ),
                  Text(
                    "No Edisi :",
                    style: DetailJurnalText(),
                  ),
                  Text(
                    x.noEdisi,
                    style: ContentJurnalText(),
                  ),
                  Text(
                    "Tempat Diumumkan :",
                    style: DetailJurnalText(),
                  ),
                ],
              ),
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
        width: 100.h,
        height: 70.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: MyColor.primaryColor),
      ),
    );
  }
}
