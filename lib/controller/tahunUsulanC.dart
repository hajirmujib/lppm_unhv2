import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/model/tahunUsulanM.dart';
import 'package:lppm_unhv2/services/tahunUsulanS.dart';

import 'package:lppm_unhv2/widget/myColor.dart';

class TahunUsulanC extends GetxController {
  var isLoading = true.obs;
  var loadingDetail = true.obs;
  var visibility = false.obs;
  var isUp = true.obs;
  var tahunList = List<Tahun>.empty().obs;

  //field add and update
  String tahun = "";
  final tahunTxt = TextEditingController();
  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    getTahun();
    super.onInit();
  }

  Future getTahun() async {
    isLoading(true);
    try {
      var res = await TahunUsulanServices().getTahunUsulan();
      if (res != null) {
        tahunList.assignAll(res);
      } else {
        tahunList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return tahunList;
  }

  Future<void> addTahun() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await TahunUsulanServices.addTahun(
          tahun: this.tahun,
          status: "Buka",
        );

        if (res[0] == "berhasil") {
          this.shotToast("Berhasil");
          tahunList.refresh();
          getTahun();
          this.tahunTxt.text = "";
        } else {
          this.shotToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editTahun({String tahun, String id}) async {
    isLoading(true);

    try {
      List res = await TahunUsulanServices.editTahun(
        id: id,
        tahun: tahun,
        status: "Tutup",
      );

      if (res[0] == "berhasil") {
        tahunList.refresh();

        this.shotToast("Berhasil");
        tahunList.refresh();
        getTahun();
      } else {
        this.shotToast("Gagal");
        print(res[0]);
        print(res[1]);
        print(res[2]);
      }
    } finally {
      isLoading(false);
    }
  }

  void shotToast(String message) {
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
        // deleteJurnal(id: id);
      },
    );
  }
}
