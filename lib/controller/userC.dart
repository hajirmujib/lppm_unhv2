import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/loginC.dart';
import 'package:lppm_unhv2/model/UserM.dart';

import 'package:lppm_unhv2/services/userS.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UsersC extends GetxController {
  var isLoading = true.obs;
  var isShow = true.obs;
  var userList = List<User>.empty().obs;
  var reviewerList = List<User>.empty().obs;
  var listuserLogin = List<User>.empty().obs;
  final LoginC loginC = Get.put(LoginC());
  var levelU = "".obs;
  void setIsShow() {
    isShow(isShow.value == true ? false : true);
  }

  String nama = "";
  String nidn = "";
  String password = "";
  String email = "";
  String level = "";
  String fakultas = "";
  String prodi = "";

  var idU = "".obs;

  var foto = File("").obs;

  final key = new GlobalKey<FormState>();

  @override
  void onInit() {
    fetchUser();
    userLogin();
    super.onInit();
  }

  User userById() {
    return userList.firstWhere((element) => element.idUsers == idU.value);
  }

  Future<User> userLogin() async {
    // isLoading(true);
    var result;
    final pref = await SharedPreferences.getInstance();
    idU.value = pref.getString("idUser");
    levelU.value = pref.getString("level");
    try {
      var process = await UserServices().getUserById(id: idU.value);
      if (process != null) {
        result = process;
      } else {
        result = null;
      }
    } finally {
      isLoading(false);
    }

    return result;
  }

  Future<void> fetchUser() async {
    isLoading(true);
    try {
      var res = await UserServices().getUser();
      if (res != null) {
        userList.assignAll(res);
      } else {
        userList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return userList;
  }

  Future<void> fetchReviewer() async {
    isLoading(true);
    try {
      var res = await UserServices().getReviewer();
      if (res != null) {
        reviewerList.assignAll(res);
      } else {
        reviewerList.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return reviewerList;
  }

  pickLampiran() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      foto.value = File(result.files.single.path);

      update();
    }
  }

  Future<void> uploadUser() async {
    isLoading(true);
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        List res = await UserServices.addUser(
          nama: this.nama,
          nidn: this.nidn,
          email: this.email,
          password: this.password,
          fakultas: this.fakultas,
          prodi: this.prodi,
          level: this.level,
          foto: this.foto.value,
        );

        if (res[0] == "berhasil") {
          this._showToast("Berhasil");
          foto.value = File("");
          this.nama = "";
          this.nidn = "";
          this.email = "";
          this.password = "";
          this.prodi = "";
          this.level = "";

          Get.back();
        } else {
          foto.value = File("");
          this.nama = "";
          this.nidn = "";
          this.email = "";
          this.password = "";
          this.prodi = "";
          this.level = "";
          this._showToast("Gagal");
        }
        userList.refresh();
        fetchUser();
      } finally {
        isLoading(false);
      }
    }
  }

  Future<String> editUser() async {
    isLoading(true);
    String response;
    final form = key.currentState;

    if (form.validate()) {
      form.save();

      try {
        var u = userById();
        List res = await UserServices.editUser(
          id: u.idUsers,
          nama: this.nama == "" ? u.nama : this.nama,
          nidn: this.nidn == "" ? u.nidn : this.nidn,
          level: this.level == "" ? u.level : this.level,
          fakultas: this.fakultas == "" ? u.fakultas : this.fakultas,
          prodi: this.prodi == "" ? u.prodi : this.prodi,
          email: this.email == "" ? u.email : this.email,
          password: this.password == "" ? u.password : this.password,
          foto: this.foto.value,
        );

        if (res[0] == "berhasil") {
          userList.refresh();
          fetchUser();
          foto.value = File("");
          this.nama = "";
          this.nidn = "";
          this.email = "";
          this.password = "";
          this.prodi = "";
          this.level = "";
          userById();

          this._showToast("Berhasil");
          foto.value = File("");
          Get.back(canPop: false);
          response = "Berhasil";
        } else {
          this._showToast("Gagal");
          response = "Gagal";
        }
      } finally {
        isLoading(false);
      }
    }
    return response;
  }

  Future deleteUser({String id}) async {
    try {
      isLoading(true);

      List res = await UserServices.deleteUser(id: id);

      if (res[0] == "berhasil") {
        userList.refresh();
        fetchUser();

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

  void showDialog() {
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
        deleteUser(id: userById().idUsers);
        // artikelList.refresh();
        // fetchInformasi();
      },
    );
  }

  void editName() {
    Get.defaultDialog(
      title: "Nama",
      content: Form(
          key: key,
          child: TextFormField(
            onSaved: (e) => this.nama = e,
            initialValue: userById().nama,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editFakultas() {
    Get.defaultDialog(
      title: "Fakultas",
      content: Form(
        key: key,
        child: DropdownButtonFormField<String>(
            value: userById().fakultas,
            items: [
              DropdownMenuItem(
                child: Text("Ilmu Komputer"),
                value: "Ilmu Komputer",
              ),
              DropdownMenuItem(
                child: Text("Ilmu Sosial & Politik"),
                value: "Ilmu Sosial & Politik",
              ),
            ],
            onChanged: (String value) {
              fakultas = value;
            }),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editProdi() {
    Get.defaultDialog(
      title: "Prodi",
      content: Form(
        key: key,
        child: DropdownButtonFormField<String>(
          value: userById().prodi,
          items: [
            DropdownMenuItem(
              child: Text("Teknik Informatika"),
              value: "Teknik Informatika",
            ),
            DropdownMenuItem(
              child: Text("Sistem Informasi"),
              value: "Sistem Informasi",
            ),
            DropdownMenuItem(
              child: Text("Ilmu Pemerintahan"),
              value: "Ilmu Pemerintahan",
            ),
            DropdownMenuItem(
              child: Text("Ilmu Komunikasi"),
              value: "Ilmu Komunikasi",
            ),
            DropdownMenuItem(
              child: Text("Teknologi Informasi"),
              value: "Teknologi Informasi",
            ),
          ],
          onChanged: (String value) {
            prodi = value;
          },
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editNidn() {
    Get.defaultDialog(
      title: "Nidn",
      content: Form(
          key: key,
          child: TextFormField(
            onSaved: (e) => this.nidn = e,
            initialValue: userById().nidn,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editEmail() {
    Get.defaultDialog(
      title: "Email",
      content: Form(
          key: key,
          child: TextFormField(
            onSaved: (e) => this.email = e,
            initialValue: userById().email,
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editPass() {
    Get.defaultDialog(
      title: "Password Baru",
      content: Form(
          key: key,
          child: TextFormField(
            onSaved: (e) => this.password = e,
            initialValue: "",
          )),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }

  void editFoto() {
    Get.defaultDialog(
      title: "Foto",
      content: Form(
        key: this.key,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: foto.value.path != ""
                      ? Image.file(
                          foto.value,
                          width: 40.w,
                          height: 40.w,
                        )
                      : Image.asset(
                          "asset/image/logo_unh.png",
                          width: 40.w,
                          height: 40.w,
                        ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                onPressed: () => pickLampiran(),
                icon: Icon(
                  Icons.photo_library,
                  color: MyColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {
        this.foto.value = File("");
      },
      onConfirm: () {
        editUser();
      },
    );
  }

  void editLevel() {
    Get.defaultDialog(
      title: "Level User",
      content: Form(
        key: key,
        child: DropdownButtonFormField<String>(
          value: userById().level,
          hint: Text("Status User"),
          items: [
            DropdownMenuItem(
              child: Text("Dosen"),
              value: "dosen",
            ),
            DropdownMenuItem(
              child: Text("Reviewer"),
              value: "reviewer",
            ),
            DropdownMenuItem(
              child: Text("LPPM"),
              value: "lppm",
            ),
          ],
          onChanged: (String value) {
            level = value;
          },
        ),
      ),
      textCancel: "Batal",
      textConfirm: "Edit",
      buttonColor: MyColor.secondaryColor,
      cancelTextColor: MyColor.primaryColor,
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        editUser();
      },
    );
  }
}
