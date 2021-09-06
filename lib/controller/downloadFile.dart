import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';

class DownloadfileC extends GetxController {
  var _fileArtikel = "/fileArtikel/";
  var _fileKegiatan = "/fileKegiatan/";
  var _fileUsulan = "/fileUsulan/";
  var _fileKeluaran = "/keluaran/";
  var url;
  int progress = 0;
  ReceivePort receivePort = ReceivePort();

  @override
  void onInit() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloading file");
    receivePort.listen((message) {
      progress = message;
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.onInit();
  }

  void requestDownload({String link, String jenis}) async {
    final status = await Permission.storage.request();
    if (jenis == "fileArtikel") {
      url = _fileArtikel;
    } else if (jenis == "fileUsulan") {
      url = _fileUsulan;
    } else if (jenis == "fileKegiatan") {
      url = _fileKegiatan;
    } else if (jenis == "keluaran") {
      url = _fileKeluaran;
    }
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: BaseServices().urlFile + "/api_apk" + url + link,
        // savedDir: '/storage/emulated/0/Download/',
        savedDir: baseStorage.path,
        fileName: link,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } else {
      print("no permission");
    }
  }

  static downloadCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading file");
    sendPort.send(progress);
  }
}
