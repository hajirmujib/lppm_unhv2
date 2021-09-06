import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/artikelC.dart';
import 'package:lppm_unhv2/model/ArtikelM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:lppm_unhv2/widget/dateText.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';

class DetailNews extends StatelessWidget {
  final artikelC = Get.find<ArtikelC>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final Datum ar = artikelC.artikelById(Get.arguments['id']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
          ImageNews(
            widthScreen: widthScreen,
            heightScreen: heightScreen,
            file: ar.file,
          ),
          ContentNews(
              widthScreen: widthScreen,
              heightScreen: heightScreen,
              tanggal: ar.atkTanggal.toString(),
              isi: ar.atkIsi,
              judul: ar.atkJudul)
        ],
      )),
    );
  }
}

class ContentNews extends StatelessWidget {
  const ContentNews({
    Key key,
    @required this.widthScreen,
    @required this.heightScreen,
    @required this.isi,
    @required this.judul,
    @required this.tanggal,
  }) : super(key: key);

  final double widthScreen;
  final double heightScreen;
  final String judul;
  final String tanggal;
  final String isi;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        child: Column(
          children: [
            Center(
              child: Text(
                judul ?? "",
                style: TitleListText(),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Oleh: Admin",
                  style: DateText(),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Text(
                  tanggal ?? "",
                  style: DateText(),
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: HtmlWidget(
                      this.isi,
                      textStyle: TextStyle(fontSize: 14),
                      webView: true,
                    )),
              ],
            ),
          ],
        ),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: widthScreen,
        height: heightScreen / 2 + 35,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
      ),
    );
  }
}

class ImageNews extends StatelessWidget {
  const ImageNews({
    Key key,
    @required this.widthScreen,
    @required this.heightScreen,
    @required this.file,
  }) : super(key: key);

  final double widthScreen;
  final double heightScreen;
  final String file;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            child: file == ""
                ? Image.asset(
                    "asset/image/logo_unh.png",
                    width: widthScreen,
                    height: heightScreen / 3,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    BaseServices().urlFile + "/api_apk/fileArtikel/" + file,
                    width: widthScreen,
                    height: heightScreen / 3,
                    fit: BoxFit.cover,
                    key: ValueKey(new Random().nextInt(100)),
                  ),
          ),
        ),
        width: widthScreen,
        height: heightScreen - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: MyColor.primaryColor),
      ),
    );
  }
}
