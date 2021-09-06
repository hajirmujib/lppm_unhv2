import 'dart:math';

import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/pengabdianC.dart';
import 'package:lppm_unhv2/model/GrafikM.dart';
import 'package:lppm_unhv2/services/grafikS.dart';

import 'bukuC.dart';
import 'hkiC.dart';
import 'jurnalC.dart';
import 'lainyaC.dart';

class GrafikC extends GetxController {
  final penelitianC = Get.put(PenelitianC());
  final pengabdianC = Get.put(PengabdianC());
  final jurnalC = Get.put(JurnalC());
  final patenC = Get.put(PatenC());
  final hkiC = Get.put(HkiC());
  final lainyaC = Get.put(LainnyaC());
  final bukuC = Get.put(BukuC());

  var isLoading = false.obs;
  var seriesList = List<charts.Series<Grafik, String>>.empty().obs;
  var fakultas = "".obs;
  var jenis = "".obs;
  var prodi = "".obs;
  var tahunMulai = "".obs;
  var tahunSelesai = "".obs;
  var tahunMin;
  var tahunMax;
  List<String> arr = [];
  List<int> arrInt = [];

  Future getData() async {
    isLoading(true);

    try {
      if (jenis.value == "Penelitian") {
        var length = penelitianC.penelitianList.length;
        for (var i = 0; i < length; i++) {
          var x = penelitianC.penelitianList[i];

          arr.add(x.tahun);
        }
        arrInt = arr.map(int.parse).toList();
        arrInt = arrInt.toSet().toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      } else if (jenis.value == "Jurnal") {
        var length = jurnalC.jurnalList.length;
        for (var i = 0; i < length; i++) {
          var x = jurnalC.jurnalList[i];

          arr.add(x.tahun);
        }
        List<int> arrInt = arr.map(int.parse).toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      } else if (jenis.value == "Pengabdian") {
        var length = pengabdianC.penelitianList.length;
        for (var i = 0; i < length; i++) {
          var x = pengabdianC.penelitianList[i];

          arr.add(x.tahun);
        }
        arrInt = arr.map(int.parse).toList();
        arrInt = arrInt.toSet().toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      } else if (jenis.value == "Paten") {
        var length = patenC.patenList.length;
        for (var i = 0; i < length; i++) {
          var x = patenC.patenList[i];

          arr.add(x.tahun);
        }
        arrInt = arr.map(int.parse).toList();
        arrInt = arrInt.toSet().toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      } else if (jenis.value == "Hki") {
        var length = hkiC.hkiList.length;
        for (var i = 0; i < length; i++) {
          var x = hkiC.hkiList[i];

          arr.add(x.tahun);
        }
        arrInt = arr.map(int.parse).toList();
        arrInt = arrInt.toSet().toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      } else if (jenis.value == "Buku") {
        var length = bukuC.bukuList.length;
        for (var i = 0; i < length; i++) {
          var x = bukuC.bukuList[i];

          arr.add(x.tahun);
        }
        arrInt = arr.map(int.parse).toList();
        arrInt = arrInt.toSet().toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      } else if (jenis.value == "Lainya") {
        var length = lainyaC.lainnyaList.length;
        for (var i = 0; i < length; i++) {
          var x = lainyaC.lainnyaList[i];

          arr.add(x.tahun);
        }
        arrInt = arr.map(int.parse).toList();
        arrInt = arrInt.toSet().toList();

        tahunMin = arrInt.cast<num>().reduce(min);
        tahunMax = arrInt.cast<num>().reduce(max);
      }
      await GrafikServices()
          .grafikSearch(
              fakultas: fakultas.value ?? "",
              prodi: prodi.value ?? "",
              tahunMulai: tahunMulai.value ?? "",
              tahunSelesai: tahunSelesai.value ?? "",
              jenis: jenis.value ?? "")
          .then((value) {
        if (value != null) {
          seriesList.assignAll([
            charts.Series<Grafik, String>(
              id: "Grafik Penelitian",
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (Grafik grafik, _) => grafik.tahun,
              measureFn: (Grafik grafik, _) => int.parse(grafik.jumlah),
              data: value,
            ),
          ]);
        }
      });
    } finally {
      isLoading(false);
    }
  }
}
