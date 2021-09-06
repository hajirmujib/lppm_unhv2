import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/BukuM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class BukuServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Buku>> getBuku() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/buku"));
    if (res.statusCode == 200) {
      var response = bukuMFromJson(res.body);
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

  Future<List<Buku>> getBukuDosen({String idUser}) async {
    var x;

    final res = await http.get(
        Uri.http(BaseServices().ip, "/api_apk/api/buku", {"id_user": idUser}));
    if (res.statusCode == 200) {
      var response = bukuMFromJson(res.body);
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

  // Future<Buku> getJurnalSumberDanaTahun(
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

  Future<Buku> bukuPenelitian({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip, "/api_apk/api/buku",
        {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = bukuMFromJson(res.body);
        x = json.data[0];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteBuku({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/buku/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addBuku({
    String idPenelitian,
    String judul,
    String pengarang,
    String penerbit,
    String ketebalan,
    String tahunTerbit,
    String noEdisi,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/buku");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['judul'] = judul == null ? "" : judul;
    request.fields['pengarang'] = pengarang == null ? "" : pengarang;
    request.fields['penerbit'] = penerbit == null ? "" : penerbit;
    request.fields['ketebalan'] = ketebalan == null ? "" : ketebalan;
    request.fields['no_edisi'] = noEdisi == null ? "" : noEdisi;
    request.fields['tahun_terbit'] = tahunTerbit == null ? "" : tahunTerbit;
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

  static Future<List> editBuku({
    String id,
    String idPenelitian,
    String judul,
    String pengarang,
    String penerbit,
    String ketebalan,
    String tahunTerbit,
    String noEdisi,
    String idUser,
    File file,
  }) async {
    List x;
    var uri = Uri.parse(url + "/buku/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (file.path != "") {
      var streamImage = http.ByteStream(StreamView(file.openRead()));
      var lengthImage = await file.length();

      request.files.add(http.MultipartFile('file', streamImage, lengthImage,
          filename: path.basename(file.path)));
    }

    request.fields['judul'] = judul == null ? "" : judul;
    request.fields['pengarang'] = pengarang == null ? "" : pengarang;
    request.fields['penerbit'] = penerbit == null ? "" : penerbit;
    request.fields['ketebalan'] = ketebalan == null ? "" : ketebalan;
    request.fields['no_edisi'] = noEdisi == null ? "" : noEdisi;
    request.fields['tahun_terbit'] = tahunTerbit == null ? "" : tahunTerbit;
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

  Future<List<Buku>> bukuSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/buku", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
    if (res.statusCode == 200) {
      var response = bukuMFromJson(res.body);
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
