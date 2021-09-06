import 'dart:convert';
import 'dart:io';

import 'package:lppm_unhv2/model/UserM.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';

class UserServices {
  static String url = "http://" + BaseServices().ip + "/api_apk/api";
  // final String url = BaseServices().url;

  Future<List<User>> getUser() async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/User"));
    if (res.statusCode == 200) {
      var response = userModelFromJson(res.body);
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

  Future<List<User>> getReviewer() async {
    var x;

    final res = await http
        .get(Uri.http(BaseServices().ip, "/api_apk/api/User/reviewer"));
    if (res.statusCode == 200) {
      var response = userModelFromJson(res.body);
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

  Future<User> getUserById({String id}) async {
    var x;

    final res =
        await http.get(Uri.http(BaseServices().ip, "/api_apk/api/user", {
      "id_users": id,
    }));
    if (res.statusCode == 200) {
      var response = userModelFromJson(res.body);
      var decode = json.decode(res.body);
      if (response.status == true) {
        x = User.fromJson(decode['data'][0]);
      } else {
        x = null;
      }
    } else {
      x = null;
    }

    return x;
  }

  static Future<List> deleteUser({String id}) async {
    var x;
    final Map<String, dynamic> data = {
      "id_users": id,
    };

    final response = await http.post(
        Uri.http(BaseServices().ip, "/api_apk/api/User/delete"),
        body: data);

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["gagal", "2"];
    }

    return x;
  }

  static Future<List> addUser(
      {String nama,
      String nidn,
      String email,
      String password,
      String level,
      String fakultas,
      String prodi,
      File foto}) async {
    List x;
    var uri = Uri.parse(url + "/User");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (foto.path != "") {
      var streamImage = http.ByteStream(StreamView(foto.openRead()));
      var lengthImage = await foto.length();

      request.files.add(http.MultipartFile('foto', streamImage, lengthImage,
          filename: path.basename(foto.path)));
    }

    request.fields['nama'] = nama == null ? "" : nama;
    request.fields['nidn'] = nidn == null ? "" : nidn;
    request.fields['email'] = email == null ? "" : email;
    request.fields['password'] = password == null ? "" : password;
    request.fields['fakultas'] = fakultas == null ? "" : fakultas;
    request.fields['prodi'] = prodi == null ? "" : prodi;
    request.fields['level'] = level == null ? "" : level;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }

  static Future<List> editUser(
      {String id,
      String nama,
      String nidn,
      String email,
      String password,
      String level,
      String fakultas,
      String prodi,
      File foto}) async {
    List x;
    var uri = Uri.parse(url + "/User/update");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (foto.path != "") {
      var streamImage = http.ByteStream(StreamView(foto.openRead()));
      var lengthImage = await foto.length();

      request.files.add(http.MultipartFile('foto', streamImage, lengthImage,
          filename: path.basename(foto.path)));
    }

    request.fields['nama'] = nama == null ? "" : nama;
    request.fields['nidn'] = nidn == null ? "" : nidn;
    request.fields['email'] = email == null ? "" : email;
    request.fields['password'] = password == null ? "" : password;
    request.fields['fakultas'] = fakultas == null ? "" : fakultas;
    request.fields['prodi'] = prodi == null ? "" : prodi;
    request.fields['level'] = level == null ? "" : level;
    request.fields['id_users'] = id == null ? "" : id;

    var response = await request.send();

    if (response.statusCode == 201) {
      x = ["berhasil"];
    } else {
      x = ["Gagal"];
    }
    return x;
  }
}
