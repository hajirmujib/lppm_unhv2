import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/catatanModel.dart';
import 'package:lppm_unhv2/model/penelitianM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class CatatanHarianServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Penelitian>> getCatatanHarian() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian"));
    if (res.statusCode == 200) {
      var response = penelitianModelFromJson(res.body);
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

  Future<List<CatatanHarian>> idCatatanHarian({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/catatan", {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = catatanMFromJson(res.body);
        x = json.data;
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteCatatan({String id}) async {
    var x;

    final response = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/catatan/delete", {
      "id_file": id,
    }));

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addCatatan({
    String idPenelitian,
    String keterangan,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/catatan");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['id_penelitian'] = idPenelitian == null ? "" : idPenelitian;
    request.fields['keterangan'] = keterangan == null ? "" : keterangan;
    request.fields['id_user'] = idUser == null ? "" : idUser;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editPenelitian({
    String id,
    String judul,
    String tahun,
    String jenis,
    String status,
    String sumberDana,
    String danaTersedia,
    String danaTerpakai,
    String idUser,
  }) async {
    List x;
    var uri = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/penelitian/edit"),
        body: {
          "id_penelitian": id,
          "judul": judul,
          "jenis": jenis,
          "status": status,
          "sumber_dana": sumberDana,
          "dana_tersedia": danaTersedia,
          "dana_terpakai": danaTerpakai,
          "id_user": idUser,
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
