import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/tahunUsulanC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/model/detailProposal.dart';
import 'package:lppm_unhv2/model/tahunUserM.dart';
import 'package:lppm_unhv2/model/tahunUsulanM.dart';
import 'package:lppm_unhv2/model/usulanProposal.dart';

import 'package:lppm_unhv2/services/usulanProposalS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UsulanProposalC extends GetxController {
  var isLoading = true.obs;
  var loadingDetail = true.obs;
  var visibility = false.obs;
  var isUp = true.obs;
  var proposalList = List<UsulanProposal>.empty().obs;
  var listTahunPengabdian = List<TahunUser>.empty().obs;
  var listTahunPenelitian = List<TahunUser>.empty().obs;
  var listPengabdian = List<UsulanProposal>.empty().obs;
  var listPenelitian = List<UsulanProposal>.empty().obs;
  var proposalBaru = List<UsulanProposal>.empty().obs;

  final userC = Get.put(UsersC());

  //field add and update
  var status = "".obs;
  String judul = "";
  String jenis = "";
  String idUser = "";
  String idReviewer = "";
  var proposal = File("").obs;
  String proposalText = "";
  var idProposal = "".obs;
  var tahunPengabdian = "".obs;
  var tahunPenelitian = "".obs;

  var hTopContainer = 22.h.obs;
  var _maxLine = 5.obs;
  final key = new GlobalKey<FormState>();
  final keyProposal = new GlobalKey<FormState>();
  final keyAdd = new GlobalKey<FormState>();

  setUp() => isUp.value == true ? isUp(false) : isUp(true);

  get maxLine => _maxLine.value;
  setMaxLine() => _maxLine.value == 5 ? _maxLine.value = 1 : _maxLine.value = 5;

  setHtopContainer() => hTopContainer.value == 22.h
      ? hTopContainer.value = 80.h
      : hTopContainer.value = 22.h;

  setVisibel() {
    if (hTopContainer.value == 22.h) {
      visibility(false);
    } else {
      visibility(true);
    }
  }

  @override
  void onInit() {
    // RevUsulanProposal();
    // lppmUsulanProposal();
    // proposalById();
    super.onInit();
  }

  Future<DetailProposalModel> proposalById() async {
    DetailProposalModel response;
    loadingDetail(true);

    try {
      var res = await UsulanProposalServices()
          .idProposalServices(idProposal: this.idProposal.value);

      if (res != null) {
        response = DetailProposalModel.fromJson(res[0]);
      }
    } finally {
      loadingDetail(false);
    }
    return response;
  }

  Future<void> lppmUsulanProposal() async {
    isLoading(true);
    try {
      var res = await UsulanProposalServices().lppmgetUsulanProposal();
      if (res != null) {
        proposalList.assignAll(res);
      } else {
        proposalList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return proposalList;
  }

  Future<void> lppmUsulanBaru() async {
    isLoading(true);
    try {
      var res = await UsulanProposalServices().lppmgetUsulanBaru();
      if (res != null) {
        proposalBaru.assignAll(res);
      } else {
        proposalBaru.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return proposalBaru;
  }

  Future<void> dosenTahunPenelitian() async {
    isLoading(true);
    try {
      final idUser = userC.idU.value;
      var res = await UsulanProposalServices()
          .idUserUsulanProposal(idUser: idUser, jenis: "penelitian");
      if (res != null) {
        listTahunPenelitian.assignAll(res);
        print(res);
      } else {
        listTahunPenelitian.assignAll([]);
        print(res);
        print(idUser);
      }
    } finally {
      isLoading(false);
    }
    return listTahunPenelitian;
  }

  Future<void> dosenTahunPengabdian() async {
    isLoading(true);
    try {
      final idUser = userC.idU.value;
      var res = await UsulanProposalServices()
          .idUserUsulanProposal(idUser: idUser, jenis: "pengabdian");
      if (res != null) {
        listTahunPengabdian.assignAll(res);
        print(res);
      } else {
        listTahunPengabdian.assignAll([]);
        print(res);
        print(idUser);
      }
    } finally {
      isLoading(false);
    }

    return listTahunPengabdian;
  }

  Future<void> dosenPenelitian() async {
    isLoading(true);
    try {
      final idUser = userC.idU.value;

      var res2 = await UsulanProposalServices().userProposalTahunJenis(
          idUser: idUser, jenis: "penelitian", tahun: tahunPenelitian.value);

      if (res2 != null) {
        listPenelitian.assignAll(res2);
      } else {
        listPenelitian.assignAll([]);
      }
    } finally {
      isLoading(false);
    }
    return listPenelitian;
  }

  Future<void> dosenPengabdian() async {
    isLoading(true);
    try {
      final idUser = userC.idU.value;

      var res2 = await UsulanProposalServices().userProposalTahunJenis(
          idUser: idUser, jenis: "pengabdian", tahun: tahunPengabdian.value);
      if (res2 != null) {
        listPengabdian.assignAll(res2);
      } else {
        listPengabdian.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return listPengabdian;
  }

  Future<void> revUsulanProposal() async {
    isLoading(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("idUser");
    try {
      var res = await UsulanProposalServices()
          .revgetUsulanProposal(idReviewer: id, status: this.status.value);
      if (res != null) {
        proposalList.assignAll(res);
      } else {
        proposalList.assignAll([]);
        print(this.status.value);
        print(id);
      }
    } finally {
      isLoading(false);
    }

    return proposalList;
  }

  Future<void> revUsulanProposalBaru() async {
    isLoading(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("idUser");
    try {
      var res = await UsulanProposalServices()
          .revgetUsulanProposal(idReviewer: id, status: "Review");
      if (res != null) {
        proposalList.assignAll(res);
      } else {
        proposalList.assignAll([]);
        print(this.status.value);
        print(id);
      }
    } finally {
      isLoading(false);
    }

    return proposalList;
  }

  Future<void> revUsulanProposalRevisi() async {
    isLoading(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("idUser");
    try {
      var res = await UsulanProposalServices()
          .revgetUsulanProposal(idReviewer: id, status: "Revisi");
      if (res != null) {
        proposalList.assignAll(res);
      } else {
        proposalList.assignAll([]);
        print(this.status.value);
        print(id);
      }
    } finally {
      isLoading(false);
    }

    return proposalList;
  }

  Future<void> revUsulanProposalDiterima() async {
    isLoading(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("idUser");
    try {
      var res = await UsulanProposalServices()
          .revgetUsulanProposal(idReviewer: id, status: "Diterima");
      if (res != null) {
        proposalList.assignAll(res);
      } else {
        proposalList.assignAll([]);
        print(this.status.value);
        print(id);
      }
    } finally {
      isLoading(false);
    }

    return proposalList;
  }

  pickProposalFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      proposal.value = File(result.files.single.path);

      update();
    }
  }

  Future<void> addProposal() async {
    final userC = Get.put(UsersC());
    final tahunC = Get.put(TahunUsulanC());
    Tahun tahunL = tahunC.tahunList.first;
    isLoading(true);
    final form = keyAdd.currentState;
    if (form.validate()) {
      form.save();
      try {
        List res = await UsulanProposalServices.addProposal(
          judul: this.judul,
          status: "Review",
          jenis: this.jenis,
          proposal: this.proposal.value,
          idUser: userC.idU.value,
          idReviewer: "14",
          tahun: tahunL.tahun,
        );

        if (res[0] == "berhasil") {
          proposalList.refresh();
          proposalById();
          // revUsulanProposal();
          lppmUsulanProposal();

          this.showToast("Berhasil");
          proposal.value = File("");
          Get.back();
        } else {
          this.showToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> editProposal() async {
    isLoading(true);
    final form = keyProposal.currentState;
    if (form.validate()) {
      form.save();

      try {
        List res = await UsulanProposalServices.editProposal(
          id: this.idProposal.value,
          judul: this.judul,
          status: this.status.value,
          jenis: this.jenis,
          proposal: this.proposal.value,
          idUser: this.idUser,
          idReviewer: this.idReviewer,
          tahun: this.tahunPenelitian.value,
        );

        if (res[0] == "berhasil") {
          proposalList.refresh();
          proposalById();
          // revUsulanProposal();
          lppmUsulanProposal();
          dosenTahunPenelitian();
          dosenTahunPengabdian();
          revUsulanProposalDiterima();
          revUsulanProposalBaru();
          revUsulanProposalRevisi();

          this.showToast("Berhasil");
          proposal.value = File("");
          Get.back();
        } else {
          this.showToast("Gagal");
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future deleteProposal({String id}) async {
    try {
      isLoading(true);

      List res = await UsulanProposalServices.deleteProposal(id: id);

      if (res[0] == "berhasil") {
        proposalList.refresh();
        listPenelitian.refresh();
        listPengabdian.refresh();
        listTahunPenelitian.refresh();
        listTahunPengabdian.refresh();
        // dosenPenelitian();
        // dosenPengabdian();
        dosenTahunPenelitian();
        dosenTahunPengabdian();

        this.showToast("Berhasil");

        Get.back();
      } else {
        print(res[1]);
        this.showToast("gagal");
      }
    } finally {
      isLoading(false);
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
        deleteProposal(id: id);
      },
    );
  }

  void editReviewer() {
    final user = Get.put(UsersC());
    Get.defaultDialog(
      title: "Edit Reviewer",
      content: SingleChildScrollView(
        child: Container(
          width: 60.w,
          height: 10.h,
          child: Form(
            key: keyProposal,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              value: idReviewer,
              items: user.reviewerList
                  .map((reviewer) => DropdownMenuItem(
                      value: reviewer.idUsers.toString(),
                      child: Text(
                        reviewer.nama.toString() +
                            " ( " +
                            reviewer.nidn.toString() +
                            " )",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        softWrap: false,
                      )))
                  .toList(),
              onChanged: (String value) {
                idReviewer = value;
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
        if (idUser == idReviewer) {
          showToast("Proposal Tidak Boleh Di Review Oleh Orang Yang Sama");
        }
        editProposal();
      },
    );
  }

  void editStatus() {
    Get.defaultDialog(
      title: "Edit Status",
      content: SingleChildScrollView(
        child: Container(
          width: 60.w,
          height: 10.h,
          child: Form(
            key: keyProposal,
            child: DropdownButtonFormField<String>(
              value: this.status.value,
              items: [
                DropdownMenuItem(
                  child: Text("Diterima"),
                  value: "Diterima",
                ),
                DropdownMenuItem(
                  child: Text("Revisi"),
                  value: "Revisi",
                ),
                DropdownMenuItem(
                  child: Text("Tidak Diterima"),
                  value: "Tidak Diterima",
                ),
                DropdownMenuItem(
                  child: Text("Review"),
                  value: "Review",
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
        editProposal();
      },
    );
  }

  void editJudul() {
    Get.defaultDialog(
      title: "Edit Judul",
      content: Form(
        key: keyProposal,
        child: Column(
          children: [
            Text("Judul Propsoal"),
            TextFormField(
              onSaved: (e) => this.judul = e,
              maxLines: 4,
              initialValue: this.judul,
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
        editProposal();
      },
    );
  }

  void editFile() {
    Get.defaultDialog(
      title: "Edit Proposal",
      content: Form(
        key: keyProposal,
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
                        this.pickProposalFile();
                      },
                    ),
                    this.proposal.value.path != ""
                        ? Expanded(
                            child: Text(
                              this.proposal.value.path.split('/').last,
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 3,
                            ),
                          )
                        : Expanded(
                            child: Text(
                              this.proposalText.toString() == ""
                                  ? "File Name"
                                  : this.proposalText.toString(),
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
        proposal.value = File("");
      },
      onConfirm: () {
        editProposal();
      },
    );
  }
}
