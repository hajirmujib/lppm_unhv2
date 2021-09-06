import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/BukuM.dart';
import 'package:lppm_unhv2/services/bukuS.dart';

import 'package:lppm_unhv2/widget/myColor.dart';

class BukuC extends GetxController {
  final userC = Get.put(UsersC());
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var bukuList = List<Buku>.empty().obs;

  String judul = "";
  String penerbit = "";
  String pengarang = "";
  String tahunTerbit = "";
  String ketebalan = "";
  String noEdisi = "";

  var fileTxt = "".obs;
  var file = File("").obs;
  var idBuku = "".obs;
  //field get api
  var idUser = "".obs;
  var idPenelitian = "".obs;

  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchBuku();
    super.onInit();
  }

  Buku bukuById() {
    return bukuList.firstWhere((element) => element.id == this.idBuku.value);
  }

  Future<Buku> bukuPenelitian() async {
    isLoading2(true);
    Buku result;
    try {
      var res = await BukuServices().bukuPenelitian(
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

  Future<void> searcBuku(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    isLoading(true);
    try {
      var res = await BukuServices().bukuSearch(
          fakultas: fakultas,
          prodi: prodi,
          tahunMulai: tahunMulai,
          tahunSelesai: tahunSelesai);
      if (res != null) {
        bukuList.assignAll(res);
      } else {
        bukuList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return bukuList;
  }

  Future<void> fetchBuku() async {
    isLoading(true);
    try {
      if (userC.levelU.value == "lppm") {
        var res = await BukuServices().getBuku();
        if (res != null) {
          bukuList.assignAll(res);
        } else {
          bukuList.assignAll([]);
        }
      } else {
        var res = await BukuServices().getBukuDosen(idUser: userC.idU.value);
        if (res != null) {
          bukuList.assignAll(res);
        } else {
          bukuList.assignAll([]);
        }
      }
    } finally {
      isLoading(false);
    }

    return bukuList;
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

  Future<void> uploadBuku() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await BukuServices.addBuku(
            judul: this.judul,
            penerbit: this.penerbit,
            pengarang: this.pengarang,
            tahunTerbit: this.tahunTerbit,
            noEdisi: this.noEdisi,
            ketebalan: this.ketebalan,
            idPenelitian:
                this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
            idUser: userC.idU.value,
            file: this.file.value);

        if (res[0] == "berhasil") {
          this._showToast("Berhasil");
          file.value = File("");
          bukuList.refresh();
          fetchBuku();
          Get.back();
        } else {
          this._showToast("Gagal");
          print(this.idPenelitian.value);
        }
        bukuList.refresh();
        fetchBuku();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editBuku() async {
    isLoading(true);
    final form = key.currentState;
    if (form.validate()) {
      form.save();

      try {
        List res = await BukuServices.editBuku(
            id: idBuku.value,
            judul: this.judul,
            penerbit: this.penerbit,
            pengarang: this.pengarang,
            tahunTerbit: this.tahunTerbit,
            noEdisi: this.noEdisi,
            ketebalan: this.ketebalan,
            idPenelitian:
                this.idPenelitian.value == "" ? "16" : this.idPenelitian.value,
            idUser: userC.idU.value,
            file: this.file.value);

        if (res[0] == "berhasil") {
          bukuList.refresh();
          fetchBuku();

          bukuById();

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

  Future deleteBuku({String id}) async {
    try {
      isLoading(true);

      List res = await BukuServices.deleteBuku(id: id);

      if (res[0] == "berhasil") {
        bukuList.refresh();
        fetchBuku();

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
        deleteBuku(id: id);
      },
    );
  }
}
