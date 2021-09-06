import 'package:lppm_unhv2/model/GrafikM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class GrafikServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";

  Future<List<Grafik>> grafikSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai,
      String jenis}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/grafik", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai,
      "jenis": jenis
    }));
    if (res.statusCode == 200) {
      var response = grafikMFromJson(res.body);
      if (response.status == true) {
        x = response.data;
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }
}
