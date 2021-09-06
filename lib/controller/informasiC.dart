import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/model/InforM.dart';

import 'package:lppm_unhv2/services/infoS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';

class InformasiC extends GetxController {
  var isLoading = true.obs;
  var informasiList = List<Informasi>.empty().obs;

  String judulInformasi = "";
  var lampiran = File("").obs;

  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchInformasi();
    super.onInit();
  }

  Informasi informasiById(String id) {
    return informasiList.firstWhere((element) => element.idInfo == id);
  }

  Future<void> fetchInformasi() async {
    isLoading(true);
    try {
      var res = await InformasiServices().getInformasi();
      if (res != null) {
        informasiList.assignAll(res);
      } else {
        informasiList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return informasiList;
  }

  pickLampiran() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      lampiran.value = File(result.files.single.path);

      update();
    }
  }

  Future<void> uploadInformasi() async {
    isLoading(true);
    final form = key.currentState;

    await keyEditor.currentState.getText().then((value) async {
      await keyEditor.currentState.getText().then((value) async {
        if (form.validate()) {
          form.save();

          try {
            List res = await InformasiServices.addInformasi(
                judul: this.judulInformasi,
                file: this.lampiran.value,
                isi: value);

            if (res[0] == "berhasil") {
              this._showToast("Berhasil");
              lampiran.value = File("");
              informasiList.refresh();
              fetchInformasi();
              Get.back();
            } else {
              this._showToast("Gagal");
            }
            informasiList.refresh();
            fetchInformasi();
          } finally {
            isLoading(false);
          }
        }
      });
    });
  }

  Future<void> editInformasi({String id}) async {
    isLoading(true);
    final form = key.currentState;

    await keyEditor.currentState.getText().then((value) async {
      await keyEditor.currentState.getText().then((value) async {
        if (form.validate()) {
          form.save();

          print(this.judulInformasi);

          print(value);

          try {
            List res = await InformasiServices.editInformasi(
                id: id,
                judul: this.judulInformasi,
                file: this.lampiran.value,
                isi: value);

            if (res[0] == "berhasil") {
              informasiList.refresh();
              fetchInformasi();

              informasiById(id);

              this._showToast("Berhasil");
              lampiran.value = File("");
              Get.back();
            } else {
              this._showToast("Gagal");
            }
          } finally {
            isLoading(false);
          }
        }
      });
    });
  }

  Future deleteInformasi({String id}) async {
    try {
      isLoading(true);

      List res = await InformasiServices.deleteInformasi(id: id);

      if (res[0] == "berhasil") {
        informasiList.refresh();
        fetchInformasi();

        this._showToast("Berhasil");

        Get.back();
      } else {
        this._showToast("gagal");
      }
    } finally {
      isLoading(false);
    }
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
        deleteInformasi(id: id);
        // artikelList.refresh();
        // fetchInformasi();
      },
    );
  }
}
