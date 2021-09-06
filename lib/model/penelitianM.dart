// To parse this JSON data, do
//
//     final penelitianModel = penelitianModelFromJson(jsonString);

import 'dart:convert';

PenelitianModel penelitianModelFromJson(String str) =>
    PenelitianModel.fromJson(json.decode(str));

String penelitianModelToJson(PenelitianModel data) =>
    json.encode(data.toJson());

class PenelitianModel {
  PenelitianModel({
    this.status,
    this.data,
  });

  bool status;
  List<Penelitian> data;

  factory PenelitianModel.fromJson(Map<String, dynamic> json) =>
      PenelitianModel(
        status: json["status"],
        data: List<Penelitian>.from(
            json["data"].map((x) => Penelitian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Penelitian {
  Penelitian({
    this.idPenelitian,
    this.judul,
    this.tahun,
    this.tanggal,
    this.jenis,
    this.status,
    this.idUser,
    this.sumberDana,
    this.danaTersedia,
    this.danaTerpakai,
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

  String idPenelitian;
  String judul;
  String tahun;
  DateTime tanggal;
  String jenis;
  String status;
  String idUser;
  String sumberDana;
  String danaTersedia;
  String danaTerpakai;
  String idUsers;
  String nama;
  String nidn;
  String foto;
  String email;
  String password;
  String level;
  String fakultas;
  String prodi;

  factory Penelitian.fromJson(Map<String, dynamic> json) => Penelitian(
        idPenelitian: json["id_penelitian"],
        judul: json["judul"],
        tahun: json["tahun"],
        tanggal: DateTime.parse(json["tanggal"]),
        jenis: json["jenis"],
        status: json["status"],
        idUser: json["id_user"],
        sumberDana: json["sumber_dana"],
        danaTersedia: json["dana_tersedia"],
        danaTerpakai: json["dana_terpakai"],
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
        "id_penelitian": idPenelitian,
        "judul": judul,
        "tahun": tahun,
        "tanggal": tanggal.toIso8601String(),
        "jenis": jenis,
        "status": status,
        "id_user": idUser,
        "sumber_dana": sumberDana,
        "dana_tersedia": danaTersedia,
        "dana_terpakai": danaTerpakai,
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
