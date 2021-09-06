import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/PatenM.dart';
import 'package:lppm_unhv2/services/patenS.dart';

import 'package:lppm_unhv2/widget/myColor.dart';

class PatenC extends GetxController {
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var patenList = List<Paten>.empty().obs;
  final userC = Get.put(UsersC());

  String judulInvansi = "";
  String noPermohonan = "";
  String tglPengajuan = "";
  DateTime tglPengajuandate;
  String pemohon = "";
  String tahun = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  var file = File("").obs;
  var idPaten = "".obs;
  var fileTxt = "".obs;
  //field get api
  var idUser = "".obs;
  var idPenelitian = "".obs;

  final key = new GlobalKey<FormState>();
  final keyEdit = new GlobalKey<FormState>();

  @override
  void onInit() {
    fethPaten();
    super.onInit();
  }

  Paten patenById() {
    return patenList.firstWhere((element) => element.id == this.idPaten.value);
  }

  Future<Paten> patenPenelitian() async {
    isLoading2(true);
    Paten result;
    try {
      var res = await PatenServices().patenPenelitian(
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

  Future<void> searchPaten(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    isLoading(true);
    try {
      var res = await PatenServices().patenSearch(
          fakultas: fakultas,
          prodi: prodi,
          tahunMulai: tahunMulai,
          tahunSelesai: tahunSelesai);
      if (res != null) {
        patenList.assignAll(res);
      } else {
        patenList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return patenList;
  }

  Future<void> fethPaten() async {
    isLoading(true);
    try {
      if (userC.levelU.value == "lppm") {
        var res = await PatenServices().getPaten();
        if (res != null) {
          patenList.assignAll(res);
        } else {
          patenList.assignAll([]);
        }
      } else {
        var res = await PatenServices().getPatenDosen(idUser: userC.idU.value);
        if (res != null) {
          patenList.assignAll(res);
        } else {
          patenList.assignAll([]);
        }
      }
    } finally {
      isLoading(false);
    }

    return patenList;
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

  Future<void> uploadPaten() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await PatenServices.addPaten(
            judulInvensi: this.judulInvansi,
            tglPengajuan: this.tglPengajuan.toString(),
            noPermohonan: this.noPermohonan,
            pemohon: this.pemohon,
            idPenelitian:
                this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
            idUser: this.idUser.value,
            file: this.file.value);

        if (res[0] == "berhasil") {
          patenList.refresh();
          fethPaten();
          this._showToast("Berhasil");
          file.value = File("");
          fileTxt.value = "";
          Get.back();
        } else {
          this._showToast("Gagal");
        }
        patenList.refresh();
        fethPaten();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editPaten() async {
    isLoading(true);
    final form = keyEdit.currentState;
    // if (form.validate()) {
    print("berhail");
    form.save();

    try {
      List res = await PatenServices.editPaten(
          id: idPaten.value,
          judulInvensi: this.judulInvansi,
          tglPengajuan: this.tglPengajuan.toString(),
          noPermohonan: this.noPermohonan,
          pemohon: this.pemohon,
          idPenelitian:
              this.idPenelitian.value == "" ? 0 : this.idPenelitian.value,
          idUser: this.idUser.value,
          file: this.file.value);

      if (res[0] == "berhasil") {
        patenList.refresh();
        fethPaten();

        patenById();

        this._showToast("Berhasil");
        file.value = File("");
        fileTxt.value = "";
        Get.back();
      } else {
        this._showToast("Gagal");
      }
    } finally {
      isLoading(false);
    }
    // }
  }

  Future deletePaten({String id}) async {
    try {
      isLoading(true);

      List res = await PatenServices.deletePaten(id: id);

      if (res[0] == "berhasil") {
        patenList.refresh();
        fethPaten();

        this._showToast("Berhasil");

        Get.back();
      } else {
        this._showToast("gagal");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateFormat formater = DateFormat("yyyy-MM-dd");
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2001),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate = picked;
      tglPengajuan = picked.toString();
      dateController.text = formater.format(picked);
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
        deletePaten(id: id);
      },
    );
  }
}
