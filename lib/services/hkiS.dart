import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/HkiM.dart';
import 'package:lppm_unhv2/model/jurnalM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class HkiServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<HKI>> getHki() async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip, "/api_apk/api/hki"));
    if (res.statusCode == 200) {
      var response = hkiMFromJson(res.body);
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

  Future<List<HKI>> getHkiDosen({String idUser}) async {
    var x;

    final res = await http.get(
        Uri.http(BaseServices().ip, "/api_apk/api/hki", {"id_user": idUser}));
    if (res.statusCode == 200) {
      var response = hkiMFromJson(res.body);
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

  Future<HKI> hkiPenelitian({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip, "/api_apk/api/hki",
        {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = hkiMFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteHki({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/hki/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addHki({
    String idPenelitian,
    String noPermohonan,
    String judul,
    String tglPermohonan,
    String nama,
    String jenisCiptaan,
    String tglDiumumkan,
    String tempatDiumumkan,
    String jangkaWaktu,
    String noPencatatan,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/hki");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['judul_ciptaan'] = judul == null ? "" : judul;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['no_permohonan'] = noPermohonan == null ? "" : noPermohonan;
    request.fields['tgl_permohonan'] =
        tglPermohonan == null ? "" : tglPermohonan;
    request.fields['nama'] = nama == null ? "" : nama;
    request.fields['jenis_ciptaan'] = jenisCiptaan == null ? "" : jenisCiptaan;
    request.fields['tgl_diumumkan'] = tglDiumumkan == null ? "" : tglDiumumkan;
    request.fields['tempat_diumumkan'] =
        tempatDiumumkan == null ? "" : tempatDiumumkan;
    request.fields['jangka_waktu'] = jangkaWaktu == null ? "" : jangkaWaktu;
    request.fields['no_pencatatan'] = noPencatatan == null ? "" : noPencatatan;
    request.fields['id_users'] = idUser == null ? "" : idUser;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editHki({
    String id,
    String idPenelitian,
    String noPermohonan,
    String judul,
    String tglPermohonan,
    String nama,
    String jenisCiptaan,
    String tglDiumumkan,
    String tempatDiumumkan,
    String jangkaWaktu,
    String noPencatatan,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/hki/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['judul_ciptaan'] = judul == null ? "" : judul;
    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['no_permohonan'] = noPermohonan == null ? "" : noPermohonan;
    request.fields['tgl_permohonan'] =
        tglPermohonan == null ? "" : tglPermohonan;
    request.fields['nama'] = nama == null ? "" : nama;
    request.fields['jenis_ciptaan'] = jenisCiptaan == null ? "" : jenisCiptaan;
    request.fields['tgl_diumumkan'] = tglDiumumkan == null ? "" : tglDiumumkan;
    request.fields['tempat_diumumkan'] =
        tempatDiumumkan == null ? "" : tempatDiumumkan;
    request.fields['jangka_waktu'] = jangkaWaktu == null ? "" : jangkaWaktu;
    request.fields['no_pencatatan'] = noPencatatan == null ? "" : noPencatatan;
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

  Future<List<HKI>> hkiSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip, "/api_apk/api/hki", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
    if (res.statusCode == 200) {
      var response = hkiMFromJson(res.body);
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
