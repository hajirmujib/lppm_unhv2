import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/jurnalM.dart';

import 'package:lppm_unhv2/services/jurnalS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';

class JurnalC extends GetxController {
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var jurnalList = List<Jurnal>.empty().obs;
  var jurnalDosenlList = List<Jurnal>.empty().obs;
  var userC = Get.put(UsersC());

  String judulJurnal = "";
  String no = "";
  String volume = "";
  String tahun = "";
  String link = "";
  String skema = "";
  var skemaTxt = "".obs;
  var abstrakTxt = "".obs;
  var coverTxt = "".obs;
  var abstrak = File("").obs;
  var cover = File("").obs;
  var idJurnal = "".obs;
  //field get api

  var idUser = "".obs;
  var idPenelitian = "".obs;
  var tahunPenelitian = "".obs;
  var sumberDana = "".obs;

  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchJurnal();
    fetchJurnalDosen();
    super.onInit();
  }

  Jurnal jurnalById() {
    return jurnalList
        .firstWhere((element) => element.id == this.idJurnal.value);
  }

  Future<Jurnal> jurnalPenelitian() async {
    isLoading2(true);
    Jurnal result;
    try {
      var res = await JurnalServices().jurnalPenlitian(
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

  Future<void> fetchJurnal() async {
    isLoading(true);
    try {
      var res = await JurnalServices().getJurnal();
      if (res != null) {
        jurnalList.assignAll(res);
      } else {
        jurnalList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return jurnalList;
  }

  Future<List<Jurnal>> fetchJurnalDosen() async {
    isLoading(true);
    try {
      var res = await JurnalServices().getJurnalDosen(idUser: userC.idU.value);
      if (res != null) {
        jurnalDosenlList.assignAll(res);
      } else {
        jurnalDosenlList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return jurnalDosenlList;
  }

  pickCover() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      cover.value = File(result.files.single.path);
      coverTxt.value = "";
      update();
    }
  }

  pickAbstrak() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      abstrak.value = File(result.files.single.path);
      abstrakTxt.value = "";
      update();
    }
  }

  Future<void> uploadJurnal() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await JurnalServices.addJurnal(
          judul: this.judulJurnal,
          link: this.link,
          cover: this.cover.value,
          abstrak: this.abstrak.value,
          no: this.no,
          volume: this.volume,
          tahun: this.tahun,
          skema: this.skema,
          idPenelitian:
              this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
          idUser: this.idUser.value,
        );

        if (res[0] == "berhasil") {
          this._showToast("Berhasil");
          jurnalDosenlList.refresh();
          jurnalList.refresh();
          fetchJurnal();
          fetchJurnalDosen();
          cover.value = File("");
          abstrak.value = File("");
          coverTxt.value = "";
          abstrakTxt.value = "";

          Get.back();
        } else {
          this._showToast("Gagal");
        }
        jurnalList.refresh();
        fetchJurnal();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editJurnal() async {
    isLoading(true);
    final form = key.currentState;
    if (form.validate()) {
      form.save();

      try {
        List res = await JurnalServices.editJurnall(
          id: this.idJurnal.value,
          judul: this.judulJurnal,
          link: this.link,
          cover: this.cover.value,
          abstrak: this.abstrak.value,
          no: this.no,
          volume: this.volume,
          tahun: this.tahun,
          skema: this.skema,
          idPenelitian: this.idPenelitian.value,
          idUser: this.idUser.value,
        );

        if (res[0] == "berhasil") {
          jurnalList.refresh();
          fetchJurnal();
          jurnalDosenlList.refresh();
          fetchJurnalDosen();
          jurnalById();

          this._showToast("Berhasil");
          cover.value = File("");
          abstrak.value = File("");
          Get.back();
        } else {
          print(res[1]);
          this._showToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> searchJurnal(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    isLoading(true);
    try {
      var res = await JurnalServices().jurnalSearch(
          fakultas: fakultas,
          prodi: prodi,
          tahunMulai: tahunMulai,
          tahunSelesai: tahunSelesai);
      if (res != null) {
        jurnalList.assignAll(res);
      } else {
        jurnalList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return jurnalList;
  }

  Future deleteJurnal({String id}) async {
    try {
      isLoading(true);

      List res = await JurnalServices.deleteJurnal(id: id);

      if (res[0] == "berhasil") {
        jurnalList.refresh();
        jurnalDosenlList.refresh();
        fetchJurnalDosen();
        fetchJurnal();

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
        deleteJurnal(id: id);
        // artikelList.refresh();
        // fetchArtikel();
      },
    );
  }
}
