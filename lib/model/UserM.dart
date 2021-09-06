// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.data,
  });

  bool status;
  List<User> data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.idUsers,
    this.nama,
    this.nidn,
    this.foto,
    this.email,
    this.password,
    this.level,
    this.fakultas,
    this.prodi,
  });

  String idUsers;
  String nama;
  String nidn;
  String foto;
  String email;
  String password;
  String level;
  String fakultas;
  String prodi;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUsers: json["id_users"],
        nama: json["nama"],
        nidn: json["nidn"],
        foto: json["foto"],
        email: json["email"],
        password: json["password"],
        level: json["level"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
      );

  Map<String, dynamic> toJson() => {
        "id_users": idUsers,
        "nama": nama,
        "nidn": nidn,
        "foto": foto,
        "email": email,
        "password": password,
        "level": level,
        "fakultas": fakultas,
        "prodi": prodi,
      };
}
