import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/LainyaM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class LainyaServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Lainya>> getLainya() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/lainnya"));
    if (res.statusCode == 200) {
      var response = lainyaMFromJson(res.body);
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

  // Future<Lainya> getJurnalSumberDanaTahun(
  //     {String tahun, String sumberDana}) async {
  //   var x;

  //   final res = await http.get(Uri.http(BaseServices().ip,
  //       "/api_apk/api/jurnal", {"tahun": tahun, "sumberDana": sumberDana}));
  //   if (res.statusCode == 200) {
  //     var response = jurnalModelFromJson(res.body);
  //     if (response.status == true) {
  //       x = response.data[0];
  //     } else {
  //       x = null;
  //     }
  //   } else {
  //     x = null;
  //   }

  //   return x;
  // }

  Future<Lainya> lainyaPenelitian({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/lainnya", {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = lainyaMFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteLainya({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/lainnya/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addLainya({
    String idPenelitian,
    String nama,
    String keterangan,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/lainnya");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['nama'] = nama == null ? "" : nama;
    request.fields['keterangan'] = keterangan == null ? "" : keterangan;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['id_users'] = idUser == null ? "" : idUser;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editLainya({
    String id,
    String idPenelitian,
    String nama,
    String keterangan,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/lainnya/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['nama'] = nama == null ? "" : nama;
    request.fields['keterangan'] = keterangan == null ? "" : keterangan;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['id_users'] = idUser == null ? "" : idUser;
    request.fields['id'] = id == null ? "" : id;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  Future<List<Lainya>> lainyaSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/lainnya", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
    if (res.statusCode == 200) {
      var response = lainyaMFromJson(res.body);
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
