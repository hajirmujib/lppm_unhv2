import 'dart:convert';

import 'package:lppm_unhv2/model/penelitianM.dart';
import 'package:lppm_unhv2/model/tahunUserM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class PenelitianServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<Penelitian>> getPenelitianl() async {
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

  Future<List<Penelitian>> getPengabdianl() async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian/pengabdian"));
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

  Future<List<Penelitian>> penelitianTahunSD({String tahun, String sd}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/penelitian", {"sumber_dana": sd, "tahun": tahun}));
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

  Future<List<Penelitian>> penelitianTahunDosenSD(
      {String tahun, String sd, String idUser}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip,
        "/api_apk/api/penelitian",
        {"sumber_dana": sd, "tahun": tahun, "id_user": idUser}));
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

  Future<List<Penelitian>> pengabdianTahunSD({String tahun, String sd}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip,
        "/api_apk/api/penelitian/pengabdian",
        {"sumber_dana": sd, "tahun": tahun}));
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

  Future<List<Penelitian>> pengabdianTahunDosenSD(
      {String tahun, String sd, String idUser}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip,
        "/api_apk/api/penelitian/pengabdian",
        {"sumber_dana": sd, "tahun": tahun, "id_user": idUser}));
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

  Future<List<Penelitian>> penelitianSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
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

  Future<List<Penelitian>> pengabdianSearch(
      {String fakultas,
      String prodi,
      String tahunMulai,
      String tahunSelesai}) async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian/pengabdian", {
      "fakultas": fakultas,
      "prodi": prodi,
      "tahunMulai": tahunMulai,
      "tahunSelesai": tahunSelesai
    }));
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

  Future<List<TahunUser>> penelitianSD({String sd}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian", {
      "sumber_dana": sd,
    }));
    if (res.statusCode == 200) {
      var response = tahunUserMFromJson(res.body);
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

  Future<List<TahunUser>> penelitianDosenSD({String sd, String idUser}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian", {
      "sumber_dana": sd,
      "id_user": idUser,
    }));
    if (res.statusCode == 200) {
      var response = tahunUserMFromJson(res.body);
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

  Future<List<TahunUser>> pengabdianSD({String sd}) async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian/pengabdian", {
      "sumber_dana": sd,
    }));
    if (res.statusCode == 200) {
      var response = tahunUserMFromJson(res.body);
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

  Future<List<TahunUser>> pengabdianDosenSD({String sd, String idUser}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip,
        "/api_apk/api/penelitian/pengabdian",
        {"sumber_dana": sd, "id_user": idUser}));
    if (res.statusCode == 200) {
      var response = tahunUserMFromJson(res.body);
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

  Future<List<Penelitian>> idPenelitianServices({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/penelitian", {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = penelitianModelFromJson(res.body);
        x = json.data;
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  Future<List<Penelitian>> idPengabdianServices({String idPenelitian}) async {
    var x;
    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/penelitian/pengabdian", {"id_penelitian": idPenelitian}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        final json = penelitianModelFromJson(res.body);
        x = json.data;
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deletePenelitian({String id}) async {
    var x;

    final response = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/penelitian/delete", {
      "id": id,
    }));

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addPenelitian({
    String judul,
    String jenis,
    String status,
    String sumberDana,
    String danaTersedia,
    String danaTerpakai,
    String idUser,
  }) async {
    List x;
    var uri = await http
        .post(Uri.http(BaseServices().ip, "/api_apk/api/penelitian"), body: {
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

  static Future<List> addPengabdian({
    String judul,
    String jenis,
    String status,
    String sumberDana,
    String danaTersedia,
    String danaTerpakai,
    String idUser,
  }) async {
    List x;
    var uri = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/penelitian/pengabdian"),
        body: {
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
          "tahun": tahun,
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
