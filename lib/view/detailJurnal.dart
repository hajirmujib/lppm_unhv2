import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/launchUrl.dart';
import 'package:lppm_unhv2/model/jurnalM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:lppm_unhv2/widget/contentJurnalText.dart';
import 'package:lppm_unhv2/widget/dateText.dart';
import 'package:lppm_unhv2/widget/detailJurnalText.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class DetailJurnal extends StatelessWidget {
  // const DetailJurnal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
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
        title: Text(
          "Detail Jurnal",
          style: TextStyle(color: MyColor.primaryColor, fontSize: 18),
        ),
        centerTitle: true,
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
  final JurnalC jurnalC = Get.put(JurnalC());

  @override
  Widget build(BuildContext context) {
    final Jurnal jurnal = jurnalC.jurnalById();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Text(
                jurnal.judul,
                style: TitleListText(),
                textAlign: TextAlign.center,
              )),
            ),
            Text(
              jurnal.tanggal.toString(),
              style: DateText(),
            ),
            Text(
              "Link :",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Poppins Regular",
                  fontWeight: FontWeight.w500),
            ),
            InkWell(
              onTap: () {
                LaunchUrl().launchURL(jurnal.link);
              },
              child: Text(
                jurnal.link != "" ? jurnal.link : "",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins Regular",
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: jurnal.cover == ""
                    ? Center(
                        child: Text("Tidak Ada Abstrak"),
                      )
                    : Image.network(
                        BaseServices().urlFile +
                            "/api_apk/keluaran/" +
                            jurnal.abstrak,
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 40.h,
                      ),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(5),
        width: widthScreen,
        height: heightScreen / 2 - 20,
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
  final JurnalC jurnalC = Get.put(JurnalC());

  @override
  Widget build(BuildContext context) {
    final Jurnal jurnal = jurnalC.jurnalById();
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: heightScreen / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: jurnal.cover == ""
                          ? Center(
                              child: Text(
                                "Tidak Ada Cover",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Image.network(
                              BaseServices().urlFile +
                                  "/api_apk/keluaran/" +
                                  jurnal.cover,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  width: widthScreen / 3 + 20,
                  height: heightScreen / 3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  height: heightScreen / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Volume :",
                            style: DetailJurnalText(),
                          ),
                          Text(
                            jurnal.volume,
                            style: ContentJurnalText(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Tahun :",
                            style: DetailJurnalText(),
                          ),
                          Text(
                            jurnal.tahun,
                            style: ContentJurnalText(),
                          ),
                        ],
                      ),
                      Text(
                        "Penulis :",
                        style: DetailJurnalText(),
                      ),
                      Text(
                        jurnal.nama,
                        style: ContentJurnalText(),
                      ),
                      Text(
                        "Skema :",
                        style: DetailJurnalText(),
                      ),
                      Text(
                        jurnal.skema,
                        style: ContentJurnalText(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        padding: EdgeInsets.all(5),
        width: widthScreen,
        height: heightScreen / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: MyColor.primaryColor),
      ),
    );
  }
}
