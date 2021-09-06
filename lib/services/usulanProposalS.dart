import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/tahunUserM.dart';
import 'package:lppm_unhv2/model/usulanProposal.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class UsulanProposalServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<UsulanProposal>> revgetUsulanProposal(
      {String status, String idReviewer}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/proposal", {
      "id_reviewer": idReviewer,
      "status": status,
    }));
    if (res.statusCode == 200) {
      var response = usulanProposalModelFromJson(res.body);
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

  Future<List<UsulanProposal>> lppmgetUsulanProposal() async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip, "/api_apk/api/proposal", {"status": "Diterima"}));
    if (res.statusCode == 200) {
      var response = usulanProposalModelFromJson(res.body);
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

  Future<List<UsulanProposal>> lppmgetUsulanBaru() async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip, "/api_apk/api/proposal", {"status": "Review"}));
    if (res.statusCode == 200) {
      var response = usulanProposalModelFromJson(res.body);
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

  Future<List<TahunUser>> idUserUsulanProposal(
      {String idUser, String jenis}) async {
    var x;

    final res = await http.get(Uri.http(BaseServices().ip,
        "/api_apk/api/proposal", {"id_users": idUser, "jenis": jenis}));
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

  Future<List<UsulanProposal>> userProposalTahunJenis(
      {String idUser, String jenis, String tahun}) async {
    var x;

    final res = await http.get(Uri.http(
        BaseServices().ip,
        "/api_apk/api/proposal",
        {"id_users": idUser, "jenis": jenis, "tahun": tahun}));
    if (res.statusCode == 200) {
      var response = usulanProposalModelFromJson(res.body);
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

  Future<List<dynamic>> idProposalServices({String idProposal}) async {
    var x;
    final res = await http.get(Uri.http(
        BaseServices().ip, "/api_apk/api/proposal", {"id": idProposal}));
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status'] == true) {
        x = response['data'];
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteProposal({String id}) async {
    var x;

    final response = await http.get(
      Uri.http(BaseServices().ip, "/api_apk/api/proposal/delete", {"id": id}),
    );

    if (response.statusCode == 200) {
      x = ["berhasil"];
    } else {
      x = ["gagal", response.statusCode];
    }

    return x;
  }

  static Future<List> addProposal(
      {String judul,
      String status,
      String jenis,
      String idUser,
      String idReviewer,
      String tahun,
      File proposal}) async {
    List x;
    var uri = Uri.parse(url + "/proposal");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (proposal.path != "") {
      var streamImage = http.ByteStream(StreamView(proposal.openRead()));
      var lengthImage = await proposal.length();

      request.files.add(http.MultipartFile('proposal', streamImage, lengthImage,
          filename: path.basename(proposal.path)));
    }

    request.fields['judul'] = judul == null ? "" : judul;
    request.fields['status'] = status == null ? "" : status;
    request.fields['jenis'] = jenis == null ? "" : jenis;
    request.fields['id_users'] = idUser == null ? "" : idUser;
    request.fields['id_reviewer'] = idReviewer == null ? "" : idReviewer;
    request.fields['tahun'] = tahun == null ? "" : tahun;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", response.statusCode];
    }
    return x;
  }

  static Future<List> editProposal(
      {String id,
      String judul,
      String status,
      String jenis,
      String idUser,
      String idReviewer,
      String tahun,
      File proposal}) async {
    List x;
    var uri = Uri.parse(url + "/proposal/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (proposal.path != "") {
      var streamImage = http.ByteStream(StreamView(proposal.openRead()));
      var lengthImage = await proposal.length();

      request.files.add(http.MultipartFile('proposal', streamImage, lengthImage,
          filename: path.basename(proposal.path)));
    }

    request.fields['judul'] = judul == null ? "" : judul;
    request.fields['id'] = id == null ? "" : id;
    request.fields['status'] = status == null ? "" : status;
    request.fields['jenis'] = jenis == null ? "" : jenis;
    request.fields['id_users'] = idUser == null ? "" : idUser;
    request.fields['id_reviewer'] = idReviewer == null ? "" : idReviewer;
    request.fields['tahun'] = tahun == null ? "" : tahun;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal", response.statusCode];
    }
    return x;
  }
}
