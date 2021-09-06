import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/penelitianM.dart';
import 'package:lppm_unhv2/model/tahunUserM.dart';
import 'package:lppm_unhv2/services/penelitianS.dart';
import 'package:lppm_unhv2/view/lppm/catatanHarianEksternal.dart';
import 'package:lppm_unhv2/view/lppm/catatanHarianL.dart';
import 'package:lppm_unhv2/view/lppm/listKeluaran.dart';
import 'package:lppm_unhv2/view/lppm/listKeluaranEksternal.dart';
import 'package:lppm_unhv2/view/lppm/listLaporanEksternal.dart';
import 'package:lppm_unhv2/view/lppm/listLaporanL.dart';
import 'package:lppm_unhv2/widget/itemTahun.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class PengabdianC extends GetxController {
  final userC = Get.put(UsersC());
  var isLoading = true.obs;
  var visibility = false.obs;
  var catatanVisibility = false.obs;
  var loadingDetail = true.obs;
  var isUp = true.obs;
  var catatanIsUp = true.obs;
  var penelitianList = List<Penelitian>.empty().obs;
  var penelitianInternalList = List<Penelitian>.empty().obs;
  var penelitianEksternalList = List<Penelitian>.empty().obs;
  var listTahunInternal = List<TahunUser>.empty().obs;
  var listTahunEksternal = List<TahunUser>.empty().obs;

  // final komentarTxt = TextEditingController();
  // final editTxt = TextEditingController();

  String judulPenelitian = "";
  var idPenelitian = "".obs;
  var jenis = "".obs;
  var jenisDefault = ''.obs;
  var status = "".obs;
  var sumberDana = "".obs;
  var danaTersedia = "".obs;
  var danaTerpakai = "0".obs;
  var idUser = "".obs;
  var tahun = "".obs;
  var fileCatatan = File("").obs;
  String fileTxt = "";
  var hTopContainer = 30.h.obs;
  var catatanContainer = 20.h.obs;
  var _maxLine = 5.obs;
  final key = new GlobalKey<FormState>();
  final keyEdit = new GlobalKey<FormState>();

  setUp() => isUp.value == true ? isUp(false) : isUp(true);
  setCatatanUp() =>
      catatanIsUp.value == true ? catatanIsUp(false) : catatanIsUp(true);

  get maxLine => _maxLine.value;
  setMaxLine() => _maxLine.value == 5 ? _maxLine.value = 1 : _maxLine.value = 5;

  setHtopContainer() => hTopContainer.value == 30.h
      ? hTopContainer.value = 80.h
      : hTopContainer.value = 30.h;

  setCatatanContainer() => catatanContainer.value == 20.h
      ? catatanContainer.value = 80.h
      : catatanContainer.value = 20.h;

  setVisibel() {
    if (hTopContainer.value == 30.h) {
      visibility(false);
    } else {
      visibility(true);
    }
  }

  setVisibelCatatan() {
    if (catatanContainer.value == 20.h) {
      catatanVisibility(false);
    } else {
      catatanVisibility(true);
    }
  }

  @override
  void onInit() {
    fetchPengabdian();
    getTahunEksternal();
    getTahunInternal();
    super.onInit();
  }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileCatatan.value = File(result.files.single.path);

      update();
    }
  }

  Future<Penelitian> pengabdianById() async {
    Penelitian response;
    loadingDetail(true);

    try {
      var res = await PenelitianServices()
          .idPengabdianServices(idPenelitian: this.idPenelitian.value);

      if (res != null) {
        response = res[0];
      }
    } finally {
      loadingDetail(false);
    }
    return response;
  }

  Future<void> fetchPengabdian() async {
    isLoading(true);
    try {
      var res = await PenelitianServices().getPengabdianl();
      if (res != null) {
        penelitianList.assignAll(res);
      } else {
        penelitianList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return penelitianList;
  }

  Future<void> searchPengabdian(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    isLoading(true);
    try {
      var res = await PenelitianServices().pengabdianSearch(
          fakultas: fakultas,
          prodi: prodi,
          tahunMulai: tahunMulai,
          tahunSelesai: tahunSelesai);
      if (res != null) {
        penelitianList.assignAll(res);
      } else {
        penelitianList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return penelitianList;
  }

  Future<void> getTahunInternal() async {
    isLoading(true);
    try {
      if (userC.levelU.value == "lppm") {
        var res = await PenelitianServices().pengabdianSD(sd: "internal");
        if (res != null) {
          listTahunInternal.assignAll(res);
        } else {
          listTahunInternal.assignAll([]);
        }
      } else {
        var res = await PenelitianServices()
            .pengabdianDosenSD(sd: "internal", idUser: userC.idU.value);
        if (res != null) {
          listTahunInternal.assignAll(res);
        } else {
          listTahunInternal.assignAll([]);
        }
      }
    } finally {
      isLoading(false);
    }

    return listTahunInternal;
  }

  Future<void> getTahunEksternal() async {
    isLoading(true);

    try {
      if (userC.levelU.value == "lppm") {
        var res = await PenelitianServices().pengabdianSD(sd: "eksternal");
        if (res != null) {
          listTahunEksternal.assignAll(res);
        } else {
          listTahunEksternal.assignAll([]);
          print("list penelitian kosong");
        }
      } else {
        var res = await PenelitianServices()
            .pengabdianDosenSD(sd: "eksternal", idUser: userC.idU.value);
        if (res != null) {
          listTahunEksternal.assignAll(res);
        } else {
          listTahunEksternal.assignAll([]);
          print("list penelitian kosong");
        }
      }
    } finally {
      isLoading(false);
    }

    return listTahunInternal;
  }

  Future<void> getPengabdianInternal() async {
    isLoading(true);
    try {
      if (userC.levelU.value == "lppm") {
        var res = await PenelitianServices()
            .pengabdianTahunSD(sd: "internal", tahun: this.tahun.value);
        if (res != null) {
          penelitianInternalList.assignAll(res);
        } else {
          penelitianInternalList.assignAll([]);
          print(this.tahun.value);
          print("List penelitian internal kosong");
        }
      } else {
        var res = await PenelitianServices().pengabdianTahunDosenSD(
            sd: "internal", tahun: this.tahun.value, idUser: userC.idU.value);
        if (res != null) {
          penelitianInternalList.assignAll(res);
        } else {
          penelitianInternalList.assignAll([]);
          print(this.tahun.value);
          print("List penelitian internal kosong");
        }
      }
    } finally {
      isLoading(false);
    }

    return penelitianInternalList;
  }

  Future<void> getPengabdianEksternal() async {
    isLoading(true);
    try {
      if (userC.levelU.value == "lppm") {
        var res = await PenelitianServices()
            .pengabdianTahunSD(sd: "Eksternal", tahun: this.tahun.value);
        if (res != null) {
          penelitianEksternalList.assignAll(res);
        } else {
          penelitianEksternalList.assignAll([]);
          print(this.tahun.value);
          print("List penelitian Eksternal kosong");
        }
      } else {
        var res = await PenelitianServices().pengabdianTahunDosenSD(
            sd: "Eksternal", tahun: this.tahun.value, idUser: userC.idU.value);
        if (res != null) {
          penelitianEksternalList.assignAll(res);
        } else {
          penelitianEksternalList.assignAll([]);
          print(this.tahun.value);
          print("List penelitian Eksternal kosong");
        }
      }
    } finally {
      isLoading(false);
    }

    return penelitianEksternalList;
  }

  Future<void> uploadPenelitian() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await PenelitianServices.addPenelitian(
            judul: this.judulPenelitian,
            jenis: this.jenis.value,
            status: this.status.value,
            sumberDana: this.sumberDana.value,
            danaTerpakai: this.danaTerpakai.value,
            danaTersedia: this.danaTersedia.value,
            idUser: this.idUser.value);

        if (res[0] == "berhasil") {
          listTahunEksternal.refresh();
          listTahunInternal.refresh();
          penelitianEksternalList.refresh();
          penelitianInternalList.refresh();
          penelitianList.refresh();
          fetchPengabdian();
          getTahunEksternal();
          getTahunInternal();
          getPengabdianEksternal();
          getPengabdianInternal();
          this.showToast("Berhasil");

          Get.back();
        } else {
          this.showToast("Gagal");
        }
        penelitianList.refresh();
        fetchPengabdian();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editPenelitian() async {
    isLoading(true);
    final form = key.currentState;
    if (form.validate()) {
      form.save();

      try {
        List res = await PenelitianServices.editPenelitian(
          id: this.idPenelitian.value,
          judul: this.judulPenelitian,
          status: this.status.value,
          jenis: this.jenis.value,
          sumberDana: this.sumberDana.value,
          danaTersedia: this.danaTersedia.value,
          danaTerpakai: this.danaTerpakai.value,
          idUser: this.idUser.value,
        );

        if (res[0] == "berhasil") {
          penelitianList.refresh();
          penelitianEksternalList.refresh();
          penelitianInternalList.refresh();
          pengabdianById();
          listTahunEksternal.refresh();
          listTahunInternal.refresh();

          fetchPengabdian();
          getTahunEksternal();
          getTahunInternal();
          getPengabdianEksternal();
          getPengabdianInternal();

          this.showToast("Berhasil");
          fileCatatan.value = File("");
          Get.back();
        } else {
          print(res[1].toString());
          print(res[2].toString());

          this.showToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: MyColor.secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void editStatus() {
    Get.defaultDialog(
      title: "Edit Status",
      content: SingleChildScrollView(
        child: Container(
          width: 60.w,
          height: 10.h,
          child: Form(
            key: key,
            child: DropdownButtonFormField<String>(
              value: this.status.value,
              items: [
                DropdownMenuItem(
                  child: Text("Belum Selesai"),
                  value: "Belum Selesai",
                ),
                DropdownMenuItem(
                  child: Text("Selesai"),
                  value: "Selesai",
                ),
              ],
              onChanged: (String value) {
                this.status.value = value;
              },
            ),
          ),
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editPenelitian();
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
        // deleteKomentar(id: id);
        Get.back();
      },
    );
  }

  void editJudul() {
    Get.defaultDialog(
      title: "Edit Judul",
      content: Form(
        key: key,
        child: Column(
          children: [
            Text("Judul Propsoal"),
            TextFormField(
              onSaved: (e) => this.judulPenelitian = e,
              maxLines: 4,
              initialValue: this.judulPenelitian,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  hintText: "Judul",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ],
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editPenelitian();
      },
    );
  }

  void editDanaTersedia() {
    Get.defaultDialog(
      title: "Edit Dana Tersedia",
      content: Form(
        key: key,
        child: Column(
          children: [
            Text("Dana Tersedia"),
            TextFormField(
              onSaved: (e) => this.danaTersedia.value = e,
              maxLines: 1,
              initialValue: this.danaTersedia.value,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  hintText: "Dana Tersedia (ex:7000000)",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ],
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editPenelitian();
      },
    );
  }

  void editDanaTerpakai() {
    Get.defaultDialog(
      title: "Edit Dana Terpakai",
      content: Form(
        key: key,
        child: Column(
          children: [
            Text("Dana Terpakai"),
            TextFormField(
              onSaved: (e) => this.danaTerpakai.value = e,
              maxLines: 1,
              initialValue: this.danaTerpakai.value,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo)),
                  hintText: "Dana Terpakai (ex:7000000)",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ],
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editPenelitian();
      },
    );
  }

  void optionPenelitian() {
    Get.defaultDialog(
      title: "Menu Penelitian",
      middleText: "",
      content: Column(children: [
        InkWell(
            onTap: () {
              // getPenelitianInternal();
              this.sumberDana.value == "internal"
                  ? Get.to(() => CatatanHarianL())
                  : Get.to(() => CatatanHarianEksternal());
            },
            child: ItemTahun(tahun: "Catatan Harian")),
        InkWell(
            onTap: () {
              this.sumberDana.value == "internal"
                  ? Get.to(() => ListLaporanL())
                  : Get.to(() => ListLaporanEksternal());
            },
            child: ItemTahun(tahun: "Laporan")),
        InkWell(
          onTap: () {
            this.sumberDana.value == "internal"
                ? Get.to(() => ListKeluaranL())
                : Get.to(() => ListKeluaranEksternal());
          },
          child: ItemTahun(
            tahun: "Keluaran",
          ),
        ),
      ]),
      textCancel: "Cancel",
      buttonColor: MyColor.secondaryColor,
      titleStyle: TextStyle(color: MyColor.primaryColor),
      cancelTextColor: MyColor.primaryColor,
      onCancel: () {},
    );
  }

  void editFile() {
    Get.defaultDialog(
      title: "Edit Proposal",
      content: Form(
        key: key,
        child: Column(
          children: [
            Text("File Proposal"),
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
                    this.fileCatatan.value.path != ""
                        ? Expanded(
                            child: Text(
                              this.fileCatatan.value.path.split('/').last,
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 3,
                            ),
                          )
                        : Expanded(
                            child: Text(
                              this.fileTxt.toString() == ""
                                  ? "File Name"
                                  : this.fileTxt.toString(),
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
        fileCatatan.value = File("");
      },
      onConfirm: () {
        editPenelitian();
      },
    );
  }
}
