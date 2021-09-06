import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/model/catatanModel.dart';
import 'package:lppm_unhv2/services/catatanHarianS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';

class CatatanHarianC extends GetxController {
  var isLoading = true.obs;
  var listCatatan = List<CatatanHarian>.empty().obs;
  var idFile = "".obs;
  var idPenelitian = "".obs;
  var file = File("").obs;
  var keterangan = "".obs;
  var idUser = "".obs;
  var jenis = "".obs;

  final catatanTxt = TextEditingController();
  final key = new GlobalKey<FormState>();

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file.value = File(result.files.single.path);

      update();
    }
  }

  Future<List<CatatanHarian>> catatanById() async {
    isLoading(true);

    try {
      var res = await CatatanHarianServices()
          .idCatatanHarian(idPenelitian: this.idPenelitian.value);

      if (res != null) {
        listCatatan.assignAll(res);
      } else {
        listCatatan.assignAll([]);
      }
    } finally {
      isLoading(false);
    }
    return listCatatan;
  }

  Future<void> addCatatan() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await CatatanHarianServices.addCatatan(
            idPenelitian: this.idPenelitian.value,
            keterangan: this.keterangan.value,
            file: this.file.value,
            idUser: this.idUser.value);

        if (res[0] == "berhasil") {
          _showToast("Berhasil");
          this.catatanTxt.text = "";
          file.value = File("");
          listCatatan.refresh();

          catatanById();
        } else {
          this._showToast("Gagal");
        }
        listCatatan.refresh();
        catatanById();
      } finally {
        isLoading(false);
      }
    }
  }

  Future deleteCatatan({String id}) async {
    try {
      isLoading(true);

      List res = await CatatanHarianServices.deleteCatatan(id: id);

      if (res[0] == "berhasil") {
        listCatatan.refresh();
        catatanById();

        this._showToast("Berhasil");
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
}
