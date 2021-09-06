import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/HkiM.dart';
import 'package:lppm_unhv2/services/hkiS.dart';

import 'package:lppm_unhv2/widget/myColor.dart';

class HkiC extends GetxController {
  final userC = Get.put(UsersC());
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var hkiList = List<HKI>.empty().obs;

  String judulCiptaan = "";
  String noPermohonan = "";
  String tglPermohonan = "";
  String nama = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateController2 = TextEditingController();

  String jenisCiptaan = "";
  String tglDiumumkan = "";
  String tempatDiumumkan = "";
  String jangkaWaktu = "";
  String noPencatatan = "";

  var fileTxt = "".obs;
  var file = File("").obs;
  var idHki = "".obs;
  //field get api
  var idUser = "".obs;
  var idPenelitian = "".obs;

  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchHki();

    super.onInit();
  }

  HKI hkiById() {
    return hkiList.firstWhere((element) => element.id == this.idHki.value);
  }

  Future<HKI> hkiPenelitian() async {
    isLoading2(true);
    HKI result;
    try {
      var res = await HkiServices().hkiPenelitian(
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

  Future<void> fetchHki() async {
    isLoading(true);
    try {
      if (userC.levelU.value == "lppm") {
        var res = await HkiServices().getHki();
        if (res != null) {
          hkiList.assignAll(res);
        } else {
          hkiList.assignAll([]);
        }
      } else {
        var res = await HkiServices().getHkiDosen(idUser: userC.idU.value);
        if (res != null) {
          hkiList.assignAll(res);
        } else {
          hkiList.assignAll([]);
        }
      }
    } finally {
      isLoading(false);
    }

    return hkiList;
  }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file.value = File(result.files.single.path);
      fileTxt.value = "";
      update();
    }
  }

  Future<void> uploadHki() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await HkiServices.addHki(
            judul: this.judulCiptaan,
            noPermohonan: this.noPermohonan,
            tglPermohonan: this.tglPermohonan,
            tglDiumumkan: this.tglDiumumkan,
            tempatDiumumkan: this.tempatDiumumkan,
            nama: this.nama,
            jenisCiptaan: this.jenisCiptaan,
            jangkaWaktu: this.jangkaWaktu,
            noPencatatan: this.noPencatatan,
            idPenelitian:
                this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
            idUser: this.idUser.value,
            file: this.file.value);

        if (res[0] == "berhasil") {
          this._showToast("Berhasil");
          file.value = File("");
          hkiList.refresh();
          fetchHki();
          Get.back();
        } else {
          this._showToast("Gagal");
        }
        hkiList.refresh();
        fetchHki();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> searcHki(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    isLoading(true);
    try {
      var res = await HkiServices().hkiSearch(
          fakultas: fakultas,
          prodi: prodi,
          tahunMulai: tahunMulai,
          tahunSelesai: tahunSelesai);
      if (res != null) {
        hkiList.assignAll(res);
      } else {
        hkiList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return hkiList;
  }

  Future<void> editHki() async {
    isLoading(true);
    final form = key.currentState;
    // if (form.validate()) {
    form.save();

    try {
      List res = await HkiServices.editHki(
          id: idHki.value,
          judul: this.judulCiptaan,
          noPermohonan: this.noPermohonan,
          tglPermohonan: this.tglPermohonan,
          tglDiumumkan: this.tglDiumumkan,
          tempatDiumumkan: this.tempatDiumumkan,
          nama: this.nama,
          jenisCiptaan: this.jenisCiptaan,
          jangkaWaktu: this.jangkaWaktu,
          noPencatatan: this.noPencatatan,
          idPenelitian:
              this.idPenelitian.value == "" ? 0 : this.idPenelitian.value,
          idUser: this.idUser.value,
          file: this.file.value);

      if (res[0] == "berhasil") {
        hkiList.refresh();
        fetchHki();

        hkiById();

        this._showToast("Berhasil");
        file.value = File("");

        Get.back();
      } else {
        this._showToast("Gagal");
      }
    } finally {
      isLoading(false);
    }
    // }
  }

  Future deleteHki({String id}) async {
    try {
      isLoading(true);

      List res = await HkiServices.deleteHki(id: id);

      if (res[0] == "berhasil") {
        hkiList.refresh();
        fetchHki();

        this._showToast("Berhasil");

        Get.back();
      } else {
        this._showToast("gagal");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> selectDate({BuildContext context, String jenisTgl}) async {
    DateFormat formater = DateFormat("yyyy-MM-dd");
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2001),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate = picked;
      if (jenisTgl == "permohonan") {
        tglPermohonan = picked.toString();
        dateController.text = formater.format(picked);
      } else {
        tglDiumumkan = picked.toString();
        dateController2.text = formater.format(picked);
      }
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
        deleteHki(id: id);
      },
    );
  }
}
