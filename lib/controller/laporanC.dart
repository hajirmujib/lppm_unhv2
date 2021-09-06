import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/model/laporanM.dart';
import 'package:lppm_unhv2/services/laporanS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';

class LaporanC extends GetxController {
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var listLaporanAkhir = List<Laporan>.empty().obs;
  var listLaporanKemajuan = List<Laporan>.empty().obs;

  var idPenelitian = "".obs;
  var file = File("").obs;
  var idUser = "".obs;
  final key = new GlobalKey<FormState>();

  // @override
  // void onInit() {
  //   laporanKemajuanById();
  //   super.onInit();
  // }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file.value = File(result.files.single.path);

      update();
    }
  }

  Future<Laporan> laporanAkhirById() async {
    isLoading2(true);
    Laporan result;
    try {
      var res = await LaporanServices()
          .idLaporan(idPenelitian: idPenelitian.value, jenis: "akhir");

      if (res != null) {
        result = res;
      }
      // else {
      //   listLaporanAkhir.assignAll([]);
      // }
    } finally {
      isLoading2(false);
    }
    return result;
  }

  Future<Laporan> laporanKemajuanById() async {
    Laporan result;
    try {
      isLoading(true);
      var res = await LaporanServices()
          .idLaporan(idPenelitian: idPenelitian.value, jenis: "kemajuan");

      if (res != null) {
        result = res;
      }
      // else {
      //   listLaporanKemajuan.assignAll([]);
      // }
    } finally {
      isLoading(false);
    }
    return result;
  }

  Future deleteLaporan({String id}) async {
    isLoading(true);

    try {
      List res = await LaporanServices.deleteLaporan(id: id);

      if (res[0] == "berhasil") {
        this._showToast("Berhasil");
        listLaporanKemajuan.refresh();
        listLaporanAkhir.refresh();
        laporanAkhirById();
        laporanKemajuanById();
        Get.back();
      } else {
        this._showToast("gagal");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addLaporan({String jenis}) async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await LaporanServices.addLaporan(
            idPenelitian: this.idPenelitian.value,
            jenis: jenis,
            file: this.file.value,
            idUser: this.idUser.value);

        if (res[0] == "berhasil") {
          _showToast("Berhasil");

          file.value = File("");

          // laporanAkhirById();
          // laporanKemajuanById();
          Get.back();
        } else {
          this._showToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  void formAdd({String jenisLaporan}) {
    Get.defaultDialog(
      title: "Upload Proposal",
      content: Form(
        key: key,
        child: Column(
          children: [
            Text("File Laporan"),
            Obx(() => Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(children: [
                    IconButton(
                      icon: LineIcon.upload(),
                      onPressed: () {
                        this.pickFile();
                      },
                    ),
                    this.file.value.path != ""
                        ? Expanded(
                            child: Text(
                              this.file.value.path.split('/').last,
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 3,
                            ),
                          )
                        : Expanded(
                            child: Text(
                              "File Name",
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 3,
                            ),
                          )
                  ]),
                ))
          ],
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {
        file.value = File("");
      },
      onConfirm: () {
        addLaporan(jenis: jenisLaporan);
      },
    );
  }

  void showDialog({String id}) {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Yakin Ingin Menghapus?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        deleteLaporan(id: id);
      },
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: MyColor.secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
