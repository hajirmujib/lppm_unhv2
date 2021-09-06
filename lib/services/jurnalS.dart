import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/jurnalM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class JurnalServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Jurnal>> getJurnal() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/jurnal"));
    if (res.statusCode == 200) {
      var response = jurnalModelFromJson(res.body);
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

  Future<List<Jurnal>> getJurnalDosen({String idUser}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip, "/api_apk/api/jurnal", {"id_user": idUser}));
    if (res.statusCode == 200) {
      var response = jurnalModelFromJson(res.body);
      if (response.status == true) {
        x = response.data;
        print("hai");
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  Future<Jurnal> getJurnalSumberDanaTahun(
      {String tahun, String sumberDana}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/jurnal", {"tahun": tahun, "sumberDana": sumberDana}));
    if (res.statusCode == 200) {
      var response = jurnalModelFromJson(res.body);
      if (response.status == true) {
        x = response.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  Future<Jurnal> jurnalPenlitian({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/jurnal", {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = jurnalModelFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteJurnal({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/jurnal/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addJurnal(
      {String idPenelitian,
      String link,
      String judul,
      String no,
      String volume,
      String tahun,
      String skema,
      String idUser,
      File abstrak,
      File cover}) async {
    List x;
    var uri = Uri.parse(url + "/Jurnal");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (abstrak.path != "") {
      var streamImage = http.ByteStream(StreamView(abstrak.openRead()));
      var lengthImage = await abstrak.length();

      request.files.add(http.MultipartFile('abstrak', streamImage, lengthImage,
          filename: path.basename(abstrak.path)));
    }

    if (cover.path != "") {
      var streamImage = http.ByteStream(StreamView(cover.openRead()));
      var lengthImage = await cover.length();

      request.files.add(http.MultipartFile('cover', streamImage, lengthImage,
          filename: path.basename(cover.path)));
    }

    request.fields['judul'] = judul == null ? "" : judul;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['link'] = link == null ? "" : link;
    request.fields['no'] = no == null ? "" : no;
    request.fields['volume'] = volume == null ? "" : volume;
    request.fields['tahun'] = tahun == null ? "" : tahun;
    request.fields['skema'] = skema == null ? "" : skema;
    request.fields['id_user'] = idUser == null ? "" : idUser;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editJurnall(
      {String id,
      String idPenelitian,
      String link,
      String judul,
      String no,
      String volume,
      String tahun,
      String skema,
      String idUser,
      File abstrak,
      File cover}) async {
    List x;
    var uri = Uri.parse(url + "/Jurnal/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (abstrak.path != "") {
      var streamImage = http.ByteStream(StreamView(abstrak.openRead()));
      var lengthImage = await abstrak.length();

      request.files.add(http.MultipartFile('abstrak', streamImage, lengthImage,
          filename: path.basename(abstrak.path)));
    }

    if (cover.path != "") {
      var streamImage = http.ByteStream(StreamView(cover.openRead()));
      var lengthImage = await cover.length();

      request.files.add(http.MultipartFile('cover', streamImage, lengthImage,
          filename: path.basename(cover.path)));
    }

    request.fields['judul'] = judul == null ? "" : judul;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['link'] = link == null ? "" : link;
    request.fields['no'] = no == null ? "" : no;
    request.fields['volume'] = volume == null ? "" : volume;
    request.fields['tahun'] = tahun == null ? "" : tahun;
    request.fields['skema'] = skema == null ? "" : skema;
    request.fields['id_user'] = idUser == null ? "" : idUser;
    request.fields['id'] = id == null ? "" : id;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", response.statusCode];
    }
    return x;
  }

  Future<List<Jurnal>> jurnalSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/jurnal", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
    if (res.statusCode == 200) {
      var response = jurnalModelFromJson(res.body);
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
