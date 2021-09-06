import 'dart:convert';
import 'package:lppm_unhv2/model/tahunUsulanM.dart';
import 'package:http/http.dart' as http;

import 'baseServices.dart';

class TahunUsulanServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Tahun>> getTahunUsulan() async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/proposal/tahun"));
    if (res.statusCode == 200) {
      var response = tahunModelFromJson(res.body);
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

  static Future<List> addTahun({
    String tahun,
    String status,
  }) async {
    List x;
    var uri = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/proposal/tahun"),
        body: {
          "tahun": tahun,
          "status": status,
        });
    Map<String, dynamic> res = json.decode(uri.body);

    if (uri.statusCode == 201 && res['status'] == true) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", res['status'], uri.statusCode];
    }
    return x;
  }

  static Future<List> editTahun(
      {String id, String status, String tahun}) async {
    List x;
    var uri = await http.post(
      Uri.http(BaseServices().ip, "/api_apk/api/proposal/editTahun"),
      body: {
        "id": id,
        "status": status,
        "tahun": tahun,
      },
    );
    Map<String, dynamic> res = json.decode(uri.body);

    if (uri.statusCode == 201 && res['status'] == true) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", res['status'], uri.statusCode];
    }
    return x;
  }
}
