import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lppm_unhv2/model/ArtikelM.dart';
import 'package:get/get.dart';

import 'package:lppm_unhv2/services/artikelS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';

class ArtikelC extends GetxController {
  var isLoading = true.obs;
  var artikelList = List<Datum>.empty().obs;

  String judulArtikel = "";
  var lampiran = File("").obs;

  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchArtikel();
    super.onInit();
  }

  Datum artikelById(String id) {
    return artikelList.firstWhere((element) => element.idAtk == id);
  }

  Future<void> fetchArtikel() async {
    isLoading(true);
    try {
      var res = await ArtikelServices().getArtikel();
      if (res != null) {
        artikelList.assignAll(res);
      } else {
        artikelList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return artikelList;
  }

  pickLampiran() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      lampiran.value = File(result.files.single.path);

      update();
    }
  }

  Future<void> uploadArtikel() async {
    isLoading(true);
    final form = key.currentState;

    await keyEditor.currentState.getText().then((value) async {
      await keyEditor.currentState.getText().then((value) async {
        if (form.validate()) {
          form.save();

          try {
            List res = await ArtikelServices.addArtikel(
                judul: this.judulArtikel,
                file: this.lampiran.value,
                isi: value);

            if (res[0] == "berhasil") {
              this._showToast("Berhasil");
              lampiran.value = File("");
              artikelList.refresh();
              fetchArtikel();
              Get.back();
            } else {
              this._showToast("Gagal");
            }
            artikelList.refresh();
            fetchArtikel();
          } finally {
            isLoading(false);
          }
        }
      });
    });
  }

  Future<void> editArtikel({String id}) async {
    isLoading(true);
    final form = key.currentState;

    await keyEditor.currentState.getText().then((value) async {
      await keyEditor.currentState.getText().then((value) async {
        if (form.validate()) {
          form.save();
          print(this.judulArtikel);
          print(this.lampiran.value.path);
          print(value);

          try {
            List res = await ArtikelServices.editArtikel(
                id: id,
                judul: this.judulArtikel,
                file: this.lampiran.value,
                isi: value);

            if (res[0] == "berhasil") {
              artikelList.refresh();
              fetchArtikel();

              artikelById(id);

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

  Future deleteArtikel({String id}) async {
    try {
      isLoading(true);

      List res = await ArtikelServices.deleteArtikel(id: id);

      if (res[0] == "berhasil") {
        artikelList.refresh();
        fetchArtikel();

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
        deleteArtikel(id: id);
        // artikelList.refresh();
        // fetchArtikel();
      },
    );
  }
}
