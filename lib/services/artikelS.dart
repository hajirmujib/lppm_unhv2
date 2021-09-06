import 'dart:io';

import 'package:lppm_unhv2/model/ArtikelM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class ArtikelServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Datum>> getArtikel() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/Artikel"));
    if (res.statusCode == 200) {
      var response = artikelModelFromJson(res.body);
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

  static Future<List> deleteArtikel({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/Artikel/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addArtikel({String judul, String isi, File file}) async {
    List x;
    var uri = Uri.parse(url + "/Artikel");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['atk_judul'] = judul == null ? "" : judul;
    request.fields['atk_isi'] = isi == null ? "" : isi;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editArtikel(
      {String id, String judul, String isi, File file}) async {
    List x;
    var uri = Uri.parse(url + "/Artikel/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['atk_judul'] = judul == null ? "" : judul;
    request.fields['atk_isi'] = isi == null ? "" : isi;
    request.fields['id'] = id == null ? "" : id;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }
}
