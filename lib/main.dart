import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lppm_unhv2/cekLogin.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await FlutterDownloader.initialize(debug: true);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      title: "LPPM UNH",
      debugShowCheckedModeBanner: false,
      home: CekLogin(),
      theme: ThemeData(
        primaryColor: MyColor.primaryColor,
      ),
    );
  }));
}
