import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/PatenM.dart';
import 'package:lppm_unhv2/model/jurnalM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class PatenServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Paten>> getPaten() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/paten"));
    if (res.statusCode == 200) {
      var response = patenMFromJson(res.body);
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

  Future<List<Paten>> getPatenDosen({String idUser}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip, "/api_apk/api/paten", {"id_users": idUser}));
    if (res.statusCode == 200) {
      var response = patenMFromJson(res.body);
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

  Future<Paten> patenPenelitian({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip, "/api_apk/api/paten",
        {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = patenMFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deletePaten({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/paten/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addPaten({
    String idPenelitian,
    String judulInvensi,
    String tglPengajuan,
    String noPermohonan,
    String pemohon,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/paten");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['judul_invensi'] = judulInvensi == null ? "" : judulInvensi;
    request.fields['tgl_pengajuan'] = tglPengajuan == null ? "" : tglPengajuan;
    request.fields['no_permohonan'] = noPermohonan == null ? "" : noPermohonan;
    request.fields['pemohon'] = pemohon == null ? "" : pemohon;
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

  static Future<List> editPaten(
      {String idPenelitian,
      String judulInvensi,
      String tglPengajuan,
      String noPermohonan,
      String pemohon,
      String idUser,
      File file,
      String id}) async {
    List x;
    var uri = Uri.parse(url + "/paten/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['judul_invensi'] = judulInvensi == null ? "" : judulInvensi;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['tgl_pengajuan'] = tglPengajuan == null ? "" : tglPengajuan;
    request.fields['no_permohonan'] = noPermohonan == null ? "" : noPermohonan;
    request.fields['id_users'] = idUser == null ? "" : idUser;
    request.fields['pemohon'] = pemohon == null ? "" : pemohon;
    request.fields['id'] = id == null ? "" : id;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  Future<List<Paten>> patenSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/paten", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
    if (res.statusCode == 200) {
      var response = patenMFromJson(res.body);
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
