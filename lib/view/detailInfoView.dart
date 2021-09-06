import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/controller/informasiC.dart';
import 'package:lppm_unhv2/model/InforM.dart';
import 'package:lppm_unhv2/widget/dateText.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/whiteTitleText.dart';
import 'package:sizer/sizer.dart';

class DetailInfoView extends StatelessWidget {
  // const DetailInfoView({ Key? key }) : super(key: key);
  final infoC = Get.find<InformasiC>();
  final downloadC = Get.put(DownloadfileC());

  @override
  Widget build(BuildContext context) {
    final Informasi info = infoC.informasiById(Get.arguments['id']);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        actions: [
          InkWell(
            onTap: () => downloadC.requestDownload(
                jenis: "fileArtikel", link: info.lampiran),
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: Icon(
                  Icons.cloud_download,
                  size: 20,
                )),
          ),
        ],
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
                    info.infoJudul,
                    style: WhiteTitleText(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              width: 100.w,
              height: 30.h,
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
                        info.infoTanggal.toString(),
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
                            info.infoIsi,
                            textStyle: TextStyle(fontSize: 14),
                            webView: true,
                          )),
                    ],
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
              width: 100.w,
              height: 60.h,
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
