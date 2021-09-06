import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/pengabdianC.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'bukuC.dart';
import 'hkiC.dart';
import 'jurnalC.dart';
import 'lainyaC.dart';

class ExcelPenelitian {
  final penelitianC = Get.put(PenelitianC());
  final jurnalC = Get.put(JurnalC());
  final pengabdianC = Get.put(PengabdianC());
  final patenC = Get.put(PatenC());
  final hkiC = Get.put(HkiC());
  final bukuC = Get.put(BukuC());
  final lainyaC = Get.put(LainnyaC());

  Future<void> createExcelLainya() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = ['No', 'Tahun', 'Nama Dosen'];
    sheet.importList(list, 4, 1, false);

    Range namaText = sheet.getRangeByName("J4");
    namaText.setText("Nama");
    Range fakText = sheet.getRangeByName("M4");
    fakText.setText("Keterangan");
    Range prodiText = sheet.getRangeByName("P4");
    prodiText.setText("Fakultas");
    Range volText = sheet.getRangeByName("S4");
    volText.setText("Prodi");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = lainyaC.lainnyaList.length;
    for (var i = 0; i < length; i++) {
      var x = lainyaC.lainnyaList[i];

      arr.add(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PUBLIKASI LAINYA PENELITIAN DAN PENGABDIAN");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range judulCell = sheet.getRangeByName('c4:I4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('J4:L4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('M4:O4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('P4:R4');
    prodiCell.merge();
    Range volumeCell = sheet.getRangeByName('S4:U4');
    volumeCell.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 10).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 13).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 19).cellStyle = globalStyle;

    // var length = jurnalController.lainyaC.lainyaListController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listJenis = [], listFak = [], listProdi = [], nomor = [];

    for (var i = 0; i < length; i++) {
      var x = lainyaC.lainnyaList[i];
      var objectTahun = x.tahun;
      var objectJenis = x.namaU;
      var objectNama = x.nama;
      var objcetJudul = x.keterangan;

      var objectFak = x.fakultas;
      var objectProdi = x.prodi;
      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectNama);
      listJudul.add(objcetJudul);
      listTahun.add(objectTahun);
      listJenis.add(objectJenis);
      listFak.add(objectFak);
      listProdi.add(objectProdi);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJenis, 5, 3, true);
      sheet.importList(listNama, 5, 10, true);
      sheet.importList(listJudul, 5, 13, true);
      sheet.importList(listFak, 5, 16, true);
      sheet.importList(listProdi, 5, 19, true);

      var y = 5 + i;
      var a = "C" + y.toString();
      var b = "I" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "J" + y.toString();
      var d = "L" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "M" + y.toString();
      var o = "O" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "P" + y.toString();
      var q = "R" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      var s = "S" + y.toString();
      var u = "U" + y.toString();

      Range su = sheet.getRangeByName('$s:$u');
      su.merge();

      var vC = "V" + y.toString();
      var xC = "X" + y.toString();

      Range vx = sheet.getRangeByName('$vC:$xC');
      vx.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 3).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 10).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 13).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 19).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }

  Future<void> createExcelBuku() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = [
      'No',
      'Tahun Terbit',
    ];
    sheet.importList(list, 4, 1, false);

    Range judulText = sheet.getRangeByName("D4");
    judulText.setText("Judul");
    Range pengarangText = sheet.getRangeByName("H4");
    pengarangText.setText("Pengarang");
    Range penerbitText = sheet.getRangeByName("K4");
    penerbitText.setText("Penerbit");
    Range edisiText = sheet.getRangeByName("N4");
    edisiText.setText("Edisi");
    Range ketebalanText = sheet.getRangeByName("P4");
    ketebalanText.setText("Ketebalan");
    Range fakultasText = sheet.getRangeByName("R4");
    fakultasText.setText("Fakultas");
    Range prodiText = sheet.getRangeByName("U4");
    prodiText.setText("Prodi");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = bukuC.bukuList.length;
    for (var i = 0; i < length; i++) {
      var x = bukuC.bukuList[i];

      arr.add(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PUBLIKASI BUKU PENELITIAN DAN PENGABDIAN");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range tahunTcell = sheet.getRangeByName('B4:C4');
    tahunTcell.merge();
    Range judulCell = sheet.getRangeByName('D4:G4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('H4:J4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('K4:M4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('N4:O4');
    prodiCell.merge();
    Range volumeCell = sheet.getRangeByName('P4:Q4');
    volumeCell.merge();
    Range noCell = sheet.getRangeByName('R4:T4');
    noCell.merge();
    Range tvCel = sheet.getRangeByName('U4:W4');
    tvCel.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 4).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 8).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 11).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 14).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 18).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 21).cellStyle = globalStyle;
    sheet.getRangeByName("U4:W4").cellStyle = globalStyle;

    // var length = jurnalController.listJurnalController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listPenerbit = [],
        listFak = [],
        listProdi = [],
        nomor = [],
        listKetebalan = [],
        listEdisi = [];

    for (var i = 0; i < length; i++) {
      var x = bukuC.bukuList[i];
      var objectJudul = x.judul;
      var objectPengarang = x.pengarang;
      var objectPenerbit = x.penerbit;
      var objectEdisi = x.noEdisi;
      var objectTahunTerbit = x.tahunTerbit;
      var objectketebalan = x.ketebalan;
      var objectFakultas = x.fakultas;
      var objectProdi = x.prodi;
      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectPengarang);
      listJudul.add(objectJudul);
      listTahun.add(objectTahunTerbit);
      listEdisi.add(objectEdisi);
      listFak.add(objectFakultas);
      listProdi.add(objectProdi);
      listPenerbit.add(objectPenerbit);
      listKetebalan.add(objectketebalan);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJudul, 5, 4, true);
      sheet.importList(listNama, 5, 8, true);
      sheet.importList(listPenerbit, 5, 11, true);
      sheet.importList(listEdisi, 5, 14, true);
      sheet.importList(listKetebalan, 5, 16, true);
      sheet.importList(listFak, 5, 18, true);
      sheet.importList(listProdi, 5, 21, true);
      var y = 5 + i;
      var a = "B" + y.toString();
      var b = "C" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "D" + y.toString();
      var d = "G" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "H" + y.toString();
      var o = "J" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "K" + y.toString();
      var q = "M" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      var s = "N" + y.toString();
      var u = "O" + y.toString();

      Range su = sheet.getRangeByName('$s:$u');
      su.merge();

      var vC = "P" + y.toString();
      var xC = "Q" + y.toString();

      Range vx = sheet.getRangeByName('$vC:$xC');
      vx.merge();
      var r = "R" + y.toString();
      var t = "T" + y.toString();

      Range rt = sheet.getRangeByName('$r:$t');
      rt.merge();

      var uCel = "U" + y.toString();
      var wCel = "W" + y.toString();

      Range uw = sheet.getRangeByName('$uCel:$wCel');
      uw.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 4).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 8).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 11).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 14).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 18).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 21).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 23).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }

  Future<void> createExcelHki() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = [
      'No',
      'Tahun',
      'Judul Ciptaan',
    ];
    sheet.importList(list, 4, 1, false);

    Range namaText = sheet.getRangeByName("J4");
    namaText.setText("Jenis Ciptaan");
    Range fakText = sheet.getRangeByName("M4");
    fakText.setText("Nama");
    Range prodiText = sheet.getRangeByName("P4");
    prodiText.setText("Fakultas");
    Range volText = sheet.getRangeByName("S4");
    volText.setText("Prodi");
    Range noText = sheet.getRangeByName("V4");
    noText.setText("Nomor Pencatatan");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = hkiC.hkiList.length;
    for (var i = 0; i < length; i++) {
      var x = hkiC.hkiList[i];

      arr.add(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PUBLIKASI HKI PENELITIAN DAN PENGABDIAN");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range judulCell = sheet.getRangeByName('c4:I4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('J4:L4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('M4:O4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('P4:R4');
    prodiCell.merge();
    Range volumeCell = sheet.getRangeByName('S4:U4');
    volumeCell.merge();
    Range noCell = sheet.getRangeByName('V4:Y4');
    noCell.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 10).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 13).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 19).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 22).cellStyle = globalStyle;

    // var length = jurnalController.listJurnalController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listJenis = [], listFak = [], listProdi = [], nomor = [], listNo = [];

    for (var i = 0; i < length; i++) {
      var x = hkiC.hkiList[i];
      var objectNama = x.nama;
      var objcetJudul = x.judulCiptaan;
      var objectTahun = x.tahun;
      var objectJenis = x.jenisCiptaan;
      var objectFak = x.fakultas;
      var objectProdi = x.prodi;
      var objectNo = x.noPencatatan;
      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectNama);
      listJudul.add(objcetJudul);
      listTahun.add(objectTahun);
      listJenis.add(objectJenis);
      listFak.add(objectFak);
      listProdi.add(objectProdi);
      listNo.add(objectNo);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJudul, 5, 3, true);
      sheet.importList(listJenis, 5, 10, true);
      sheet.importList(listNama, 5, 13, true);
      sheet.importList(listFak, 5, 16, true);
      sheet.importList(listProdi, 5, 19, true);
      sheet.importList(listNo, 5, 24, true);
      var y = 5 + i;
      var a = "C" + y.toString();
      var b = "I" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "J" + y.toString();
      var d = "L" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "M" + y.toString();
      var o = "O" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "P" + y.toString();
      var q = "R" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      var s = "S" + y.toString();
      var u = "U" + y.toString();

      Range su = sheet.getRangeByName('$s:$u');
      su.merge();

      var vC = "V" + y.toString();
      var xC = "X" + y.toString();

      Range vx = sheet.getRangeByName('$vC:$xC');
      vx.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 3).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 10).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 13).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 19).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 24).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }

  Future<void> createExcelPaten() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = [
      'No',
      'Tahun',
      'Judul Invensi',
    ];
    sheet.importList(list, 4, 1, false);

    Range namaText = sheet.getRangeByName("J4");
    namaText.setText("Pemohon");
    Range fakText = sheet.getRangeByName("M4");
    fakText.setText("TGL Permohonan");
    Range prodiText = sheet.getRangeByName("P4");
    prodiText.setText("Fakultas");
    Range volText = sheet.getRangeByName("S4");
    volText.setText("Prodi");
    Range noText = sheet.getRangeByName("V4");
    noText.setText("Nomor Permohonan");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = patenC.patenList.length;
    for (var i = 0; i < length; i++) {
      var x = patenC.patenList[i];

      arr.add(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PUBLIKASI PATEN PENELITIAN DAN PENGABDIAN");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range judulCell = sheet.getRangeByName('c4:I4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('J4:L4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('M4:O4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('P4:R4');
    prodiCell.merge();
    Range volumeCell = sheet.getRangeByName('S4:U4');
    volumeCell.merge();
    Range noCell = sheet.getRangeByName('V4:Y4');
    noCell.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 10).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 13).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 19).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 22).cellStyle = globalStyle;

    // var length = jurnalController.listJurnalController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listJenis = [], listFak = [], listProdi = [], nomor = [], listNo = [];

    for (var i = 0; i < length; i++) {
      var x = patenC.patenList[i];
      var objectNama = x.pemohon;
      var objcetJudul = x.judulInvensi;
      var objectTahun = x.tahun;
      String objectJenis = x.tglPengajuan.day.toString() +
          "-" +
          x.tglPengajuan.month.toString() +
          "-" +
          x.tglPengajuan.year.toString();
      var objectFak = x.fakultas;
      var objectProdi = x.prodi;
      var objectNo = x.noPermohonan;
      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectNama);
      listJudul.add(objcetJudul);
      listTahun.add(objectTahun);
      listJenis.add(objectJenis);
      listFak.add(objectFak);
      listProdi.add(objectProdi);
      listNo.add(objectNo);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJudul, 5, 3, true);
      sheet.importList(listNama, 5, 10, true);
      sheet.importList(listJenis, 5, 13, true);
      sheet.importList(listFak, 5, 16, true);
      sheet.importList(listProdi, 5, 19, true);
      sheet.importList(listNo, 5, 24, true);
      var y = 5 + i;
      var a = "C" + y.toString();
      var b = "I" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "J" + y.toString();
      var d = "L" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "M" + y.toString();
      var o = "O" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "P" + y.toString();
      var q = "R" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      var s = "S" + y.toString();
      var u = "U" + y.toString();

      Range su = sheet.getRangeByName('$s:$u');
      su.merge();

      var vC = "V" + y.toString();
      var xC = "X" + y.toString();

      Range vx = sheet.getRangeByName('$vC:$xC');
      vx.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 3).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 10).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 13).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 19).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 24).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }

  Future<void> createExcelPengabdian() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = [
      'No',
      'Tahun',
      'Judul',
    ];
    sheet.importList(list, 4, 1, false);

    Range namaText = sheet.getRangeByName("J4");
    namaText.setText("Sumber Dana");
    Range fakText = sheet.getRangeByName("M4");
    fakText.setText("Nama");
    Range prodiText = sheet.getRangeByName("P4");
    prodiText.setText("Fakultas");
    Range volText = sheet.getRangeByName("S4");
    volText.setText("Prodi");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = pengabdianC.penelitianList.length;
    for (var i = 0; i < length; i++) {
      var x = pengabdianC.penelitianList[i];

      arr.add(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();
    arrInt = arrInt.toSet().toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PENGABDIAN MASYARAKAT DOSEN UNH");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range judulCell = sheet.getRangeByName('c4:I4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('J4:L4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('M4:O4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('P4:R4');
    prodiCell.merge();
    Range volumeCell = sheet.getRangeByName('S4:U4');
    volumeCell.merge();
    Range noCell = sheet.getRangeByName('V4:Y4');
    noCell.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 10).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 13).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 19).cellStyle = globalStyle;

    // var length = jurnalController.listJurnalController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listJenis = [], listFak = [], listProdi = [], nomor = [], listNo = [];

    for (var i = 0; i < length; i++) {
      var x = pengabdianC.penelitianList[i];

      var objectNama = x.nama;
      var objcetJudul = x.judul;
      var objectTahun = x.tahun;
      var objectJenis = x.sumberDana;
      var objectFak = x.fakultas;
      var objectProdi = x.prodi;

      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectNama);
      listJudul.add(objcetJudul);
      listTahun.add(objectTahun);
      listJenis.add(objectJenis);
      listFak.add(objectFak);
      listProdi.add(objectProdi);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJudul, 5, 3, true);
      sheet.importList(listJenis, 5, 10, true);
      sheet.importList(listNama, 5, 13, true);
      sheet.importList(listFak, 5, 16, true);
      sheet.importList(listProdi, 5, 19, true);
      sheet.importList(listNo, 5, 24, true);
      var y = 5 + i;
      var a = "C" + y.toString();
      var b = "I" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "J" + y.toString();
      var d = "L" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "M" + y.toString();
      var o = "O" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "P" + y.toString();
      var q = "R" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      var s = "S" + y.toString();
      var u = "U" + y.toString();

      Range su = sheet.getRangeByName('$s:$u');
      su.merge();

      var vC = "V" + y.toString();
      var xC = "X" + y.toString();

      Range vx = sheet.getRangeByName('$vC:$xC');
      vx.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 3).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 10).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 13).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 19).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }

  Future<void> createExcelJurnal() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = [
      'No',
      'Tahun',
      'Jurnal',
    ];
    sheet.importList(list, 4, 1, false);

    Range namaText = sheet.getRangeByName("J4");
    namaText.setText("Nama");
    Range fakText = sheet.getRangeByName("M4");
    fakText.setText("Fakultas");
    Range prodiText = sheet.getRangeByName("P4");
    prodiText.setText("Prodi");
    Range volText = sheet.getRangeByName("S4");
    volText.setText("Volume");
    Range noText = sheet.getRangeByName("T4");
    noText.setText("Nomor");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = jurnalC.jurnalList.length;
    for (var i = 0; i < length; i++) {
      var x = jurnalC.jurnalList[i];

      arr.add(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PUBLIKASI JURNAL PENELITIAN DAN PENGABDIAN");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range judulCell = sheet.getRangeByName('c4:I4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('J4:L4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('M4:O4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('P4:R4');
    prodiCell.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 10).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 13).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 19).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 20).cellStyle = globalStyle;

    // var length = jurnalController.listJurnalController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listVolume = [], listFak = [], listProdi = [], nomor = [], listNo = [];

    for (var i = 0; i < length; i++) {
      var x = jurnalC.jurnalList[i];
      var objectNama = x.nama;
      var objcetJudul = x.judul;
      var objectTahun = x.tahun;
      var objectVolume = x.volume;
      var objectFak = x.fakultas;
      var objectProdi = x.prodi;
      var objectNo = x.no;
      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectNama);
      listJudul.add(objcetJudul);
      listTahun.add(objectTahun);
      listVolume.add(objectVolume);
      listFak.add(objectFak);
      listProdi.add(objectProdi);
      listNo.add(objectNo);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJudul, 5, 3, true);
      sheet.importList(listNama, 5, 10, true);
      sheet.importList(listFak, 5, 13, true);
      sheet.importList(listProdi, 5, 16, true);
      sheet.importList(listVolume, 5, 19, true);
      sheet.importList(listNo, 5, 20, true);
      var y = 5 + i;
      var a = "C" + y.toString();
      var b = "I" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "J" + y.toString();
      var d = "L" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "M" + y.toString();
      var o = "O" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "P" + y.toString();
      var q = "R" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 3).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 10).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 13).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 19).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 20).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    //style
    Style globalStyle = workbook.styles.add('style');
    Style valuesStyle = workbook.styles.add('style2');
    Style judulTableStyle = workbook.styles.add('style3');

    judulTableStyle.fontName = 'Times New Roman';
    judulTableStyle.fontSize = 14;
    judulTableStyle.bold = true;
    judulTableStyle.hAlign = HAlignType.center;

    globalStyle.borders.all.lineStyle = LineStyle.thin;
    globalStyle.borders.all.color = '#000000';
    globalStyle.backColorRgb = Color.fromARGB(245, 218, 150, 148);
    globalStyle.fontName = 'Times New Roman';
    globalStyle.fontSize = 12;
    globalStyle.bold = true;
    globalStyle.hAlign = HAlignType.center;

    valuesStyle.borders.all.lineStyle = LineStyle.thin;
    valuesStyle.borders.all.color = '#000000';
    valuesStyle.fontName = 'Times New Roman';
    valuesStyle.fontSize = 12;
    valuesStyle.hAlign = HAlignType.center;
    valuesStyle.vAlign = VAlignType.center;
    valuesStyle.wrapText = true;

    //style end

    final List<Object> list = [
      'No',
      'Tahun',
      'Judul',
    ];
    sheet.importList(list, 4, 1, false);

    Range namaText = sheet.getRangeByName("J4");
    namaText.setText("Sumber Dana");
    Range fakText = sheet.getRangeByName("M4");
    fakText.setText("Nama");
    Range prodiText = sheet.getRangeByName("P4");
    prodiText.setText("Fakultas");
    Range volText = sheet.getRangeByName("S4");
    volText.setText("Prodi");

    //mencari tahun terkecil dan terbesar
    List<String> arr = [];

    var length = penelitianC.penelitianList.length;
    for (var i = 0; i < length; i++) {
      var x = penelitianC.penelitianList[i];

      arr.add(x.tahun);
      print(x.tahun);
    }
    List<int> arrInt = arr.map(int.parse).toList();
    arrInt = arrInt.toSet().toList();

    var tahunMin = arrInt.cast<num>().reduce(min);
    var tahunMax = arrInt.cast<num>().reduce(max);

    //end

    //judul1
    Range judulTable = sheet.getRangeByName("A1");
    judulTable.setText("DATA PENELITIAN DOSEN UNH");
    Range judulTableCell = sheet.getRangeByName('A1:T1');
    judulTableCell.merge();
    Range judulTable2 = sheet.getRangeByName("A2");
    arrInt.length != 1
        ? judulTable2
            .setText("TAHUN " + tahunMin.toString() + "-" + tahunMax.toString())
        : judulTable2.setText("TAHUN " + tahunMin.toString());
    Range judulTableCell2 = sheet.getRangeByName('A2:T2');
    judulTableCell2.merge();

    Range judulCell = sheet.getRangeByName('c4:I4');
    judulCell.merge();
    Range namaCell = sheet.getRangeByName('J4:L4');
    namaCell.merge();
    Range fakultasCell = sheet.getRangeByName('M4:O4');
    fakultasCell.merge();
    Range prodiCell = sheet.getRangeByName('P4:R4');
    prodiCell.merge();
    Range volumeCell = sheet.getRangeByName('S4:U4');
    volumeCell.merge();
    Range noCell = sheet.getRangeByName('V4:Y4');
    noCell.merge();

    sheet.getRangeByIndex(1, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(2, 1).cellStyle = judulTableStyle;
    sheet.getRangeByIndex(4, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 10).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 13).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 16).cellStyle = globalStyle;
    sheet.getRangeByIndex(4, 19).cellStyle = globalStyle;

    // var length = jurnalController.listJurnalController.length;

    var listNama = [];
    var listJudul = [];
    var listTahun = [];

    var listJenis = [], listFak = [], listProdi = [], nomor = [], listNo = [];

    for (var i = 0; i < length; i++) {
      var x = penelitianC.penelitianList[i];

      var objectNama = x.nama;
      var objcetJudul = x.judul;
      var objectTahun = x.tahun;
      var objectJenis = x.sumberDana;
      var objectFak = x.fakultas;
      var objectProdi = x.prodi;

      var no = i + 1;

      nomor.add(no.toString());
      listNama.add(objectNama);
      listJudul.add(objcetJudul);
      listTahun.add(objectTahun);
      listJenis.add(objectJenis);
      listFak.add(objectFak);
      listProdi.add(objectProdi);

      sheet.importList(nomor, 5, 1, true);
      sheet.importList(listTahun, 5, 2, true);
      sheet.importList(listJudul, 5, 3, true);
      sheet.importList(listJenis, 5, 10, true);
      sheet.importList(listNama, 5, 13, true);
      sheet.importList(listFak, 5, 16, true);
      sheet.importList(listProdi, 5, 19, true);
      sheet.importList(listNo, 5, 24, true);
      var y = 5 + i;
      var a = "C" + y.toString();
      var b = "I" + y.toString();

      Range v = sheet.getRangeByName('$a:$b');
      v.merge();

      var c = "J" + y.toString();
      var d = "L" + y.toString();

      Range jl = sheet.getRangeByName('$c:$d');
      jl.merge();

      var m = "M" + y.toString();
      var o = "O" + y.toString();

      Range mo = sheet.getRangeByName('$m:$o');
      mo.merge();

      var p = "P" + y.toString();
      var q = "R" + y.toString();

      Range pq = sheet.getRangeByName('$p:$q');
      pq.merge();

      var s = "S" + y.toString();
      var u = "U" + y.toString();

      Range su = sheet.getRangeByName('$s:$u');
      su.merge();

      var vC = "V" + y.toString();
      var xC = "X" + y.toString();

      Range vx = sheet.getRangeByName('$vC:$xC');
      vx.merge();

      sheet.getRangeByIndex(5 + i, 1).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 2).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 3).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 10).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 13).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 16).cellStyle = valuesStyle;
      sheet.getRangeByIndex(5 + i, 19).cellStyle = valuesStyle;
    }

    // sheet.importList(, 1, 1, false);

    // sheet.importList(x, 1, 1, false);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getExternalStorageDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    file.writeAsBytes(bytes, flush: true);

    //  await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    OpenFile.open(fileName);
  }
}
