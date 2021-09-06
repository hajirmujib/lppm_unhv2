import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/model/komentarProposalM.dart';
import 'package:sizer/sizer.dart';
import 'package:lppm_unhv2/services/komentarProposalS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KomentarProposalC extends GetxController {
  var isLoading = true.obs;
  var komentarList = List<KomentarProposal>.empty().obs;
  final komentarTxt = TextEditingController();
  final editTxt = TextEditingController();

  // String judulInformasi = "";
  var idProposal = "".obs;
  var isi = "".obs;
  var isiEdit = "".obs;
  final key = new GlobalKey<FormState>();
  final keyEdit = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchKomentarProposal();
    super.onInit();
  }

  Future fetchKomentarProposal() async {
    isLoading(true);
    try {
      var res =
          await KomentarServices().getKomentar(idProposal: idProposal.value);
      if (res != null) {
        komentarList.assignAll(res);
      } else {
        komentarList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return komentarList;
  }

  Future<void> uploadKomentar() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      final pref = await SharedPreferences.getInstance();
      var idU = pref.getString("idUser");
      try {
        List res = await KomentarServices.addKomentar(
            idProposal: this.idProposal.value,
            idUser: idU,
            isi: this.isi.value);

        if (res[0] == "berhasil") {
          komentarTxt.text = "";
          // komentarList.refresh();
          // fetchKomentarProposal();
          this._showToast("Berhasil");

          // Get.back();
        } else {
          this._showToast("Gagal");
        }
        komentarList.refresh();
        fetchKomentarProposal();
      } finally {
        isLoading(false);
      }
    }
  }

  Future editKomentar({String id}) async {
    isLoading(true);
    final form = keyEdit.currentState;

    if (form.validate()) {
      form.save();

      final pref = await SharedPreferences.getInstance();
      var idU = pref.getString("idUser");
      try {
        List res = await KomentarServices.editKomentar(
            idKomentar: id,
            idProposal: this.idProposal.value,
            idUser: idU,
            isi: this.isiEdit.value);

        if (res[0] == "berhasil") {
          this._showToast("Berhasil");

          Get.back();
        } else {
          this._showToast("Gagal");
        }
        komentarList.refresh();
        fetchKomentarProposal();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> deleteKomentar({String id}) async {
    try {
      isLoading(true);

      List res = await KomentarServices.deleteKomentar(id: id);

      if (res[0] == "berhasil") {
        komentarList.refresh();
        fetchKomentarProposal();

        this._showToast("Berhasil");

        // Get.back();
      } else {
        this._showToast("gagal");
        print(res[0]);
        print(res[1]);
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
        deleteKomentar(id: id);
        Get.back();
      },
    );
  }

  void showEdit({String id, String isi}) {
    Get.defaultDialog(
      title: "Edit Komentar",
      middleText: "",
      content: Form(
        key: keyEdit,
        child: Container(
          width: 100.w,
          height: 20.h,
          child: TextFormField(
            initialValue: isi,
            onSaved: (e) => isiEdit.value = e,
            style: TextStyle(color: Colors.black54, fontSize: 18),
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
                hintText: "Komentar",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                fillColor: Colors.white,
                filled: true),
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
        editKomentar(id: id);
      },
    );
  }
}
