import 'dart:convert';
import 'package:lppm_unhv2/model/KomentarPenelitianM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class KomentarPenelitianServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<KomentarPenelitian>> getKomentar({String idPenelitian}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/komentar/kegiatan", {"id_kegiatan": idPenelitian}));

    if (res.statusCode == 200) {
      final response = komentarPenelitianMFromJson(res.body);
      if (response.status = true) {
        x = response.data;
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteKomentar({String id}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/komentar/kegiatanDelete", {"id_komentar": id}));

    if (res.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", res.statusCode.toString()];
    }

    return x;
  }

  static Future<List> addKomentar(
      {String idPenelitian, String isi, String idUser}) async {
    List x;
    var uri = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/komentar/kegiatan"),
        body: {
          "id_kegiatan": idPenelitian,
          "isi": isi,
          "id_users": idUser,
        });
    Map<String, dynamic> res = json.decode(uri.body);

    if (uri.statusCode == 201 && res['status'] == true) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", res['status'], uri.statusCode];
    }
    return x;
  }

  static Future<List> editKomentar(
      {String idKomentar,
      String idPenelitian,
      String isi,
      String idUser}) async {
    List x;
    var uri = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/komentar/kegiatanEdit"),
        body: {
          "id_kegiatan": idPenelitian,
          "isi": isi,
          "id_users": idUser,
          "id_komentar": idKomentar,
        });
    Map<String, dynamic> res = json.decode(uri.body);

    if (uri.statusCode == 201 && res['status'] == true) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", res['status'], uri.statusCode];
    }
    return x;
  }
}
