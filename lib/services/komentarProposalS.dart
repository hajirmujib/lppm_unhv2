import 'dart:convert';
import 'package:lppm_unhv2/model/komentarPenelitianM.dart';
import 'package:lppm_unhv2/model/komentarProposalM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class KomentarServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<KomentarProposal>> getKomentar({String idProposal}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/komentar", {"id_proposal": idProposal}));

    if (res.statusCode == 200) {
      final response = komentarProposalMFromJson(res.body);
      if (response.status = true) {
        x = response.data;
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  Future<List<KomentarPenelitian>> getKomentarPenelitian(
      {String idKegiatan}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/komentar/kegiatan", {"id_kegiatan": idKegiatan}));

    if (res.statusCode == 200) {
      final response = komentarPenelitianMFromJson(res.body);
      if (response.status = true) {
        x = response.data;
      } else {
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
        "/api_apk/api/komentar/delete", {"id_komentar": id}));

    if (res.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", res.statusCode.toString()];
    }

    return x;
  }

  static Future<List> addKomentar(
      {String idProposal, String isi, String idUser}) async {
    List x;
    var uri = await http
        .post(Uri.http(BaseServices().ip, "/api_apk/api/komentar"), body: {
      "id_proposal": idProposal,
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
      {String idKomentar, String idProposal, String isi, String idUser}) async {
    List x;
    var uri = await http
        .post(Uri.http(BaseServices().ip, "/api_apk/api/komentar/edit"), body: {
      "id_proposal": idProposal,
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
