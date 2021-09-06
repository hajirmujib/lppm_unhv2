import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/LainyaM.dart';
import 'package:lppm_unhv2/services/lainyaS.dart';

import 'package:lppm_unhv2/widget/myColor.dart';

class LainnyaC extends GetxController {
  final userC = Get.put(UsersC());
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var lainnyaList = List<Lainya>.empty().obs;

  String nama = "";
  String keterangan = "";
  var file = File("").obs;
  var idLainya = "".obs;
  var fileTxt = "".obs;
  //field get api
  var idUser = "".obs;
  var idPenelitian = "".obs;

  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fethLainya();
    super.onInit();
  }

  Lainya lainyaById() {
    return lainnyaList
        .firstWhere((element) => element.id == this.idLainya.value);
  }

  Future<Lainya> lainyaPenelitian() async {
    isLoading2(true);
    Lainya result;
    try {
      var res = await LainyaServices().lainyaPenelitian(
        idPenelitian: this.idPenelitian.value,
      );

      if (res != null) {
        result = res;
      }
    } finally {
      isLoading2(false);
    }
    return result;
  }

  Future<void> searcLainya(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    isLoading(true);
    try {
      var res = await LainyaServices().lainyaSearch(
          fakultas: fakultas,
          prodi: prodi,
          tahunMulai: tahunMulai,
          tahunSelesai: tahunSelesai);
      if (res != null) {
        lainnyaList.assignAll(res);
      } else {
        lainnyaList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return lainnyaList;
  }

  Future<void> fethLainya() async {
    isLoading(true);
    try {
      var res = await LainyaServices().getLainya();
      if (res != null) {
        lainnyaList.assignAll(res);
      } else {
        lainnyaList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return lainnyaList;
  }

  // Future<Jurnal> fetchJurnalTahunSdana() async {
  //   isLoading2(true);
  //   Jurnal result;
  //   try {
  //     var res = await JurnalServices().getJurnalSumberDanaTahun(
  //         tahun: this.tahunPenelitian.value, sumberDana: this.sumberDana.value);
  //     if (res != null) {
  //       result = res;
  //     } else {
  //       print(this.tahunPenelitian.value);
  //       print(this.sumberDana.value);
  //     }
  //   } finally {
  //     isLoading2(false);
  //   }

  //   return result;
  // }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file.value = File(result.files.single.path);
      fileTxt.value = "";
      update();
    }
  }

  Future<void> uploadLainya() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await LainyaServices.addLainya(
            nama: this.nama,
            keterangan: this.keterangan,
            idPenelitian:
                this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
            idUser: userC.idU.value,
            file: this.file.value);

        if (res[0] == "berhasil") {
          this._showToast("Berhasil");
          lainnyaList.refresh();
          fethLainya();
          file.value = File("");
          Get.back();
        } else {
          this._showToast("Gagal");
        }
        lainnyaList.refresh();
        fethLainya();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editLainya() async {
    isLoading(true);
    final form = key.currentState;
    if (form.validate()) {
      form.save();

      try {
        List res = await LainyaServices.editLainya(
            id: idLainya.value,
            nama: this.nama,
            keterangan: this.keterangan,
            idPenelitian:
                this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
            idUser: userC.idU.value,
            file: this.file.value);

        if (res[0] == "berhasil") {
          lainnyaList.refresh();
          fethLainya();

          lainyaById();

          this._showToast("Berhasil");
          file.value = File("");

          Get.back();
        } else {
          this._showToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future deleteLainya({String id}) async {
    try {
      isLoading(true);

      List res = await LainyaServices.deleteLainya(id: id);

      if (res[0] == "berhasil") {
        lainnyaList.refresh();
        fethLainya();

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
        deleteLainya(id: id);
      },
    );
  }
}
