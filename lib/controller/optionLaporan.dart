import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/excelPenelitian.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/pengabdianC.dart';
import 'package:lppm_unhv2/view/lppm/grafik.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import 'bukuC.dart';
import 'grafikC.dart';
import 'hkiC.dart';
import 'lainyaC.dart';

class OptionLaporan extends GetxController {
  final penelitianC = Get.put(PenelitianC());
  final pengabdianC = Get.put(PengabdianC());
  final jurnalC = Get.put(JurnalC());
  final grafikC = Get.put(GrafikC());
  final patenC = Get.put(PatenC());
  final hkiC = Get.put(HkiC());
  final lainyaC = Get.put(LainnyaC());
  final bukuC = Get.put(BukuC());

  var jenis = "".obs;
  List<String> prodiIlkom = [
    "Teknik Informatika",
    "Sistem Informasi",
    "Teknologi Informasi"
  ];
  List<String> allProdi = [
    "Teknik Informatika",
    "Sistem Informasi",
    "Teknologi Informasi",
    "Ilmu Pemerintahan",
    "Ilmu Komunikasi"
  ];
  List<String> prodiIlsos = ["Ilmu Pemerintahan", "Ilmu Komunikasi"];
  List<String> listFakultas = ["Ilmu Komputer", "Ilmu Sosial & Politik"];

  List<DropdownMenuItem<String>> getDropDownMenuFakultas() {
    List<DropdownMenuItem<String>> fakultas = [];
    for (String fakultasList in listFakultas) {
      fakultas.add(new DropdownMenuItem(
          value: fakultasList, child: new Text(fakultasList)));
    }
    return fakultas;
  }

  List<DropdownMenuItem<String>> getDropDownMenuProdiIlkom() {
    List<DropdownMenuItem<String>> ilkom = [];
    for (String ilkomList in prodiIlkom) {
      ilkom.add(
          new DropdownMenuItem(value: ilkomList, child: new Text(ilkomList)));
    }
    return ilkom;
  }

  List<DropdownMenuItem<String>> getDropDownMenuProdiIlsos() {
    List<DropdownMenuItem<String>> ilsos = [];
    for (String ilsosList in prodiIlsos) {
      ilsos.add(
          new DropdownMenuItem(value: ilsosList, child: new Text(ilsosList)));
    }
    return ilsos;
  }

  List<DropdownMenuItem<String>> getDropDownMenuProdiIAll() {
    List<DropdownMenuItem<String>> prodiAll = [];
    for (String prodiList in allProdi) {
      prodiAll.add(
          new DropdownMenuItem(value: prodiList, child: new Text(prodiList)));
    }
    return prodiAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunPenelitian() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in arr2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunPengabdian() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in tahunPengabdian2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunPaten() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in tahunPaten2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunJurnal() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in tahunJurnal2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunHki() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in tahunHki2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunBuku() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in tahunBuku2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  List<DropdownMenuItem<String>> getDropDownMenuTahunLainya() {
    List<DropdownMenuItem<String>> tahunAll = [];
    for (String tahunList in tahunLainya2) {
      tahunAll.add(
          new DropdownMenuItem(value: tahunList, child: new Text(tahunList)));
    }

    return tahunAll;
  }

  var _dropDownMenuProdi, _dropDownMenuFakultas, dropDownMenuTahunPenelitian;

  final _currentProdi = Rx<String>();
  final _currentFakultas = Rx<String>();
  final _tahunMulai = Rx<String>();
  final _tahunSelesai = Rx<String>();

  void changedDropDownFakultas(String selectedFakultas) {
    _dropDownMenuProdi = null;
    _currentProdi.value = null;

    _currentFakultas.value = selectedFakultas;
    if (selectedFakultas.toString() == "Ilmu Komputer") {
      _dropDownMenuProdi = getDropDownMenuProdiIlkom();
    } else if (selectedFakultas.toString() == "Ilmu Sosial & Politik") {
      _dropDownMenuProdi = getDropDownMenuProdiIlsos();
    } else if (selectedFakultas.toString() == null) {
      _dropDownMenuProdi = getDropDownMenuProdiIAll();
    }
  }

  void changedDropDownProdi(String selectedProdi) {
    _currentProdi.value = selectedProdi;
  }

  void changedDropDownTahunMulai(String selectedTahun) {
    _tahunMulai.value = selectedTahun;
  }

  void changedDropDownTahunSelesai(String selectedTahun) {
    _tahunSelesai.value = selectedTahun;
  }

  List<String> arr = [];
  List<String> arr2 = [];
  List<String> tahunJurnal = [];
  List<String> tahunJurnal2 = [];
  List<String> tahunPengabdian = [];
  List<String> tahunPengabdian2 = [];
  List<String> tahunPaten = [];
  List<String> tahunPaten2 = [];
  List<String> tahunHki = [];
  List<String> tahunHki2 = [];
  List<String> tahunBuku = [];
  List<String> tahunBuku2 = [];
  List<String> tahunLainya = [];
  List<String> tahunLainya2 = [];

  changeTahun() {
    var length = penelitianC.penelitianList.length;
    for (var i = 0; i < length; i++) {
      var x = penelitianC.penelitianList[i];

      arr.add(x.tahun);
      // print(x.tahun);
    }
    arr2 = arr.toSet().toList();
  }

  changeTahunBuku() {
    var length = bukuC.bukuList.length;
    for (var i = 0; i < length; i++) {
      var x = bukuC.bukuList[i];

      tahunBuku.add(x.tahun);
      // print(x.tahun);
    }
    tahunBuku2 = tahunBuku.toSet().toList();
  }

  changeTahunLainya() {
    var length = lainyaC.lainnyaList.length;
    for (var i = 0; i < length; i++) {
      var x = lainyaC.lainnyaList[i];

      tahunLainya.add(x.tahun);
      // print(x.tahun);
    }
    tahunLainya2 = tahunLainya.toSet().toList();
  }

  changeTahunPaten() {
    var length = patenC.patenList.length;
    for (var i = 0; i < length; i++) {
      var x = patenC.patenList[i];

      tahunPaten.add(x.tahun);
    }
    tahunPaten2 = tahunPaten.toSet().toList();
  }

  changeTahunPengabdian() {
    var length = pengabdianC.penelitianList.length;
    for (var i = 0; i < length; i++) {
      var x = pengabdianC.penelitianList[i];

      tahunPengabdian.add(x.tahun);
      // print(x.tahun);
    }
    tahunPengabdian2 = tahunPengabdian.toSet().toList();
  }

  changeTahunJurnal() {
    var length = jurnalC.jurnalList.length;
    for (var i = 0; i < length; i++) {
      var x = jurnalC.jurnalList[i];

      tahunJurnal.add(x.tahun);
      // print(x.tahun);
    }

    tahunJurnal2 = tahunJurnal.toSet().toList();
  }

  changeTahunHkil() {
    var length = hkiC.hkiList.length;
    for (var i = 0; i < length; i++) {
      var x = hkiC.hkiList[i];

      tahunHki.add(x.tahun);
      // print(x.tahun);
    }

    tahunHki2 = tahunHki.toSet().toList();
  }

  @override
  void onInit() {
    changeTahun();
    changeTahunJurnal();
    changeTahunPengabdian();
    changeTahunPaten();
    changeTahunHkil();
    changeTahunBuku();
    changeTahunLainya();
    dropDownMenuTahunPenelitian = getDropDownMenuTahunPaten();
    _dropDownMenuFakultas = getDropDownMenuFakultas();
    _dropDownMenuProdi = getDropDownMenuProdiIAll();

    // _dropDownMenuTahunPenelitian = getDropDownMenuTahunPenelitian();

    print("Menu Tahun Penelitian:" + dropDownMenuTahunPenelitian.toString());
    super.onInit();
  }

  void showDialog() {
    Get.defaultDialog(
        title: "Option Laporan",
        middleText: "",
        content: Obx(() => Column(children: [
              Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 10.h,
                child: DropdownButtonFormField<String>(
                  hint: Text("Fakultas"),
                  items: _dropDownMenuFakultas,
                  value: _currentFakultas.value,
                  onChanged: changedDropDownFakultas,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 10.h,
                  child: DropdownButtonFormField<String>(
                    hint: Text("Prodi"),
                    items: _dropDownMenuProdi,
                    value: _currentProdi.value,
                    onChanged: _currentFakultas.value == null
                        ? null
                        : changedDropDownProdi,
                  )),
              Container(
                padding: EdgeInsets.all(10.0),
                width: 90.w,
                height: 10.h,
                child: DropdownButtonFormField<String>(
                  hint: Text("Tahun Mulai"),
                  items: dropDownMenuTahunPenelitian,
                  value: _tahunMulai.value,
                  onChanged: changedDropDownTahunMulai,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: 90.w,
                height: 10.h,
                child: DropdownButtonFormField<String>(
                  hint: Text("Tahun Selesai"),
                  items: dropDownMenuTahunPenelitian,
                  value: _tahunSelesai.value,
                  onChanged: changedDropDownTahunSelesai,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        _currentFakultas.value = null;
                        _currentProdi.value = null;
                        _dropDownMenuFakultas = getDropDownMenuFakultas();
                        _dropDownMenuProdi = getDropDownMenuProdiIAll();
                        _tahunMulai.value = null;
                        _tahunSelesai.value = null;

                        // jurnalController.fetchJurnal();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: MyColor.secondaryColor,
                      ),
                      icon: LineIcon.removeFormat(
                        size: 20,
                        color: Colors.white,
                      ),
                      label: Text("Reset")),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (_tahunSelesai.value != null &&
                                _tahunMulai.value != null ||
                            _tahunSelesai.value != null &&
                                _tahunMulai.value != null &&
                                _currentFakultas.value != null &&
                                _currentProdi.value != null) {
                          if (int.parse(_tahunMulai.value) >=
                              int.parse(_tahunSelesai.value)) {
                            penelitianC.showToast(
                                "Tahun Mulai Harus Lebih Kecil Dari Tahun Selesai");
                          } else {
                            if (jenis.value == "Penelitian") {
                              await penelitianC
                                  .searchPenelitian(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                if (penelitianC.penelitianList.length != 0) {
                                  grafikC.fakultas.value =
                                      _currentFakultas.value;
                                  grafikC.prodi.value = _currentProdi.value;
                                  grafikC.tahunMulai.value = _tahunMulai.value;
                                  grafikC.tahunSelesai.value =
                                      _tahunSelesai.value;
                                  grafikC.jenis.value = "Penelitian";
                                  grafikC.getData();
                                  Get.to(() => GrafikV());
                                } else {
                                  penelitianC.showToast("Data Kosong");
                                }
                              });
                            } else if (jenis.value == "Pengabdian") {
                              await pengabdianC
                                  .searchPengabdian(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                if (pengabdianC.penelitianList.length != 0) {
                                  grafikC.fakultas.value =
                                      _currentFakultas.value;
                                  grafikC.prodi.value = _currentProdi.value;
                                  grafikC.tahunMulai.value = _tahunMulai.value;
                                  grafikC.tahunSelesai.value =
                                      _tahunSelesai.value;
                                  grafikC.jenis.value = "Pengabdian";
                                  grafikC.getData();
                                  Get.to(() => GrafikV());
                                } else {
                                  pengabdianC.showToast("Data Kosong");
                                }
                              });
                            } else if (jenis.value == 'Jurnal') {
                              await jurnalC
                                  .searchJurnal(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Jurnal";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              });
                            } else if (jenis.value == 'Paten') {
                              await patenC
                                  .searchPaten(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Paten";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              });
                            } else if (jenis.value == 'Hki') {
                              await hkiC
                                  .searcHki(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Hki";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              });
                            } else if (jenis.value == 'Buku') {
                              await bukuC
                                  .searcBuku(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Buku";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              });
                            } else if (jenis.value == 'Lainya') {
                              await lainyaC
                                  .searcLainya(
                                      fakultas: _currentFakultas.value,
                                      prodi: _currentProdi.value,
                                      tahunMulai: _tahunMulai.value,
                                      tahunSelesai: _tahunSelesai.value)
                                  .then((value) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Lainya";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              });
                            }
                          }
                        } else if (_tahunMulai.value == null &&
                                _tahunSelesai.value != null ||
                            _tahunMulai.value == "") {
                          penelitianC
                              .showToast("Tahun Mulai Tidak Boleh Kosong");
                        } else if (_tahunMulai.value == null &&
                            _tahunSelesai.value == null &&
                            _currentFakultas.value == null &&
                            _currentProdi.value == null) {
                          //cek jenis
                          if (jenis.value == "Penelitian") {
                            penelitianC.fetchPenelitian().then((value) {
                              if (penelitianC.penelitianList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Penelitian";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Pengabdian") {
                            pengabdianC.fetchPengabdian().then((value) {
                              if (penelitianC.penelitianList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Pengabdian";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Jurnal") {
                            jurnalC.fetchJurnal().then((value) {
                              if (jurnalC.jurnalList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Jurnal";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Paten") {
                            patenC.fethPaten().then((value) {
                              if (patenC.patenList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Paten";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Hki") {
                            hkiC.fetchHki().then((value) {
                              if (patenC.patenList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Hki";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Buku") {
                            bukuC.fetchBuku().then((value) {
                              if (patenC.patenList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Buku";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Lainya") {
                            lainyaC.fethLainya().then((value) {
                              if (patenC.patenList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Lainya";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          }
                        } else {
                          if (jenis.value == "Penelitian") {
                            await penelitianC
                                .searchPenelitian(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (penelitianC.penelitianList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Penelitian";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Pengabdian") {
                            await penelitianC
                                .searchPenelitian(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (penelitianC.penelitianList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Pengabdian";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Jurnal") {
                            await jurnalC
                                .searchJurnal(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (jurnalC.jurnalList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Jurnal";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Paten") {
                            await patenC
                                .searchPaten(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (patenC.patenList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Paten";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Hki") {
                            await hkiC
                                .searcHki(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (hkiC.hkiList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Hki";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Buku") {
                            await bukuC
                                .searcBuku(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (bukuC.bukuList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Buku";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          } else if (jenis.value == "Lainya") {
                            await lainyaC
                                .searcLainya(
                                    fakultas: _currentFakultas.value,
                                    prodi: _currentProdi.value,
                                    tahunMulai: _tahunMulai.value,
                                    tahunSelesai: _tahunSelesai.value)
                                .then((value) {
                              if (lainyaC.lainnyaList.length != 0) {
                                grafikC.fakultas.value = _currentFakultas.value;
                                grafikC.prodi.value = _currentProdi.value;
                                grafikC.tahunMulai.value = _tahunMulai.value;
                                grafikC.tahunSelesai.value =
                                    _tahunSelesai.value;
                                grafikC.jenis.value = "Lainya";
                                grafikC.getData();
                                Get.to(() => GrafikV());
                              } else {
                                penelitianC.showToast("Data Kosong");
                              }
                            });
                          }

                          // ExcelPenelitian().createExcel();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: MyColor.secondaryColor,
                      ),
                      icon: LineIcon.barChart(
                        size: 20,
                        color: Colors.white,
                      ),
                      label: Text("Grafik")),
                ],
              ),
            ])),
        textCancel: "Batal",
        textConfirm: "Cetak",
        buttonColor: MyColor.secondaryColor,
        cancelTextColor: MyColor.primaryColor,
        confirmTextColor: Colors.white,
        onCancel: () {
          _currentFakultas.value = null;
          _currentProdi.value = null;
          _dropDownMenuFakultas = getDropDownMenuFakultas();
          _dropDownMenuProdi = getDropDownMenuProdiIAll();
          _tahunMulai.value = null;
          _tahunSelesai.value = null;
        },
        onConfirm: () async {
          if (_tahunSelesai.value != null && _tahunMulai.value != null) {
            if (int.parse(_tahunMulai.value) >=
                int.parse(_tahunSelesai.value)) {
              penelitianC.showToast(
                  "Tahun Mulai Harus Lebih Kecil Dari Tahun Selesai");
            } else {
              if (jenis.value == "Penelitian") {
                await penelitianC
                    .searchPenelitian(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (penelitianC.penelitianList.length != 0) {
                    return ExcelPenelitian().createExcel();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              } else if (jenis.value == "Jurnal") {
                await jurnalC
                    .searchJurnal(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (jurnalC.jurnalList.length != 0) {
                    return ExcelPenelitian().createExcelJurnal();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              } else if (jenis.value == "Paten") {
                await patenC
                    .searchPaten(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (patenC.patenList.length != 0) {
                    return ExcelPenelitian().createExcelPaten();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              } else if (jenis.value == "Hki") {
                await hkiC
                    .searcHki(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (hkiC.hkiList.length != 0) {
                    return ExcelPenelitian().createExcelHki();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              } else if (jenis.value == "Pengabdian") {
                await pengabdianC
                    .searchPengabdian(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (pengabdianC.penelitianList.length != 0) {
                    return ExcelPenelitian().createExcelPengabdian();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              } else if (jenis.value == "Buku") {
                await bukuC
                    .searcBuku(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (bukuC.bukuList.length != 0) {
                    return ExcelPenelitian().createExcelBuku();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              } else if (jenis.value == "Lainya") {
                await lainyaC
                    .searcLainya(
                        fakultas: _currentFakultas.value,
                        prodi: _currentProdi.value,
                        tahunMulai: _tahunMulai.value,
                        tahunSelesai: _tahunSelesai.value)
                    .then((value) {
                  if (lainyaC.lainnyaList.length != 0) {
                    return ExcelPenelitian().createExcelLainya();
                  } else {
                    penelitianC.showToast("Data Kosong");
                  }
                });
              }
            }
          } else if (_tahunMulai.value == null && _tahunSelesai.value != null ||
              _tahunMulai.value == "") {
            penelitianC.showToast("Tahun Mulai Tidak Boleh Kosong");
          } else if (_tahunMulai.value == null &&
              _tahunSelesai.value == null &&
              _currentFakultas.value == null &&
              _currentProdi.value == null) {
            if (jenis.value == "Penelitian") {
              penelitianC.fetchPenelitian().then((value) {
                if (penelitianC.penelitianList.length != 0) {
                  ExcelPenelitian().createExcel();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Pengabdian") {
              pengabdianC.fetchPengabdian().then((value) {
                if (pengabdianC.penelitianList.length != 0) {
                  ExcelPenelitian().createExcelPengabdian();
                } else {
                  pengabdianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Jurnal") {
              jurnalC.fetchJurnal().then((value) {
                if (jurnalC.jurnalList.length != 0) {
                  ExcelPenelitian().createExcelJurnal();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Paten") {
              patenC.fethPaten().then((value) {
                if (patenC.patenList.length != 0) {
                  ExcelPenelitian().createExcelPaten();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Hki") {
              hkiC.fetchHki().then((value) {
                if (hkiC.hkiList.length != 0) {
                  ExcelPenelitian().createExcelHki();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Buku") {
              bukuC.fetchBuku().then((value) {
                if (bukuC.bukuList.length != 0) {
                  ExcelPenelitian().createExcelBuku();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Lainya") {
              lainyaC.fethLainya().then((value) {
                if (lainyaC.lainnyaList.length != 0) {
                  ExcelPenelitian().createExcelLainya();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            }
          } else {
            if (jenis.value == "Penelitian") {
              await penelitianC
                  .searchPenelitian(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (penelitianC.penelitianList.length != 0) {
                  return ExcelPenelitian().createExcel();
                } else {
                  // penelitianC.showToast("Data Kosong 3");
                  print(penelitianC.penelitianList.length);
                }
              });
            } else if (jenis.value == "Jurnal") {
              await jurnalC
                  .searchJurnal(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (jurnalC.jurnalList.length != 0) {
                  return ExcelPenelitian().createExcelJurnal();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Paten") {
              await patenC
                  .searchPaten(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (patenC.patenList.length != 0) {
                  return ExcelPenelitian().createExcelPaten();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Hki") {
              await hkiC
                  .searcHki(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (hkiC.hkiList.length != 0) {
                  return ExcelPenelitian().createExcelHki();
                } else {
                  penelitianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Pengabdian") {
              await pengabdianC
                  .searchPengabdian(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (pengabdianC.penelitianList.length != 0) {
                  return ExcelPenelitian().createExcelPengabdian();
                } else {
                  pengabdianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Buku") {
              await bukuC
                  .searcBuku(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (bukuC.bukuList.length != 0) {
                  return ExcelPenelitian().createExcelBuku();
                } else {
                  pengabdianC.showToast("Data Kosong");
                }
              });
            } else if (jenis.value == "Lainya") {
              await lainyaC
                  .searcLainya(
                      fakultas: _currentFakultas.value,
                      prodi: _currentProdi.value,
                      tahunMulai: _tahunMulai.value,
                      tahunSelesai: _tahunSelesai.value)
                  .then((value) {
                if (lainyaC.lainnyaList.length != 0) {
                  return ExcelPenelitian().createExcelPengabdian();
                } else {
                  pengabdianC.showToast("Data Kosong");
                }
              });
            }

            // ExcelPenelitian().createExcel();
          }
        });
  }
}
