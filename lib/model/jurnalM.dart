// To parse this JSON data, do
//
//     final jurnalModel = jurnalModelFromJson(jsonString);

import 'dart:convert';

JurnalModel jurnalModelFromJson(String str) =>
    JurnalModel.fromJson(json.decode(str));

String jurnalModelToJson(JurnalModel data) => json.encode(data.toJson());

class JurnalModel {
  JurnalModel({
    this.status,
    this.data,
  });

  bool status;
  List<Jurnal> data;

  factory JurnalModel.fromJson(Map<String, dynamic> json) => JurnalModel(
        status: json["status"],
        data: List<Jurnal>.from(json["data"].map((x) => Jurnal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Jurnal {
  Jurnal({
    this.id,
    this.idPenelitian,
    this.judul,
    this.no,
    this.volume,
    this.tahun,
    this.tanggal,
    this.skema,
    this.abstrak,
    this.cover,
    this.link,
    this.idUser,
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

  String id;
  String idPenelitian;
  String judul;
  String no;
  String volume;
  String tahun;
  DateTime tanggal;
  String skema;
  String abstrak;
  String cover;
  String link;
  String idUser;
  String idUsers;
  String nama;
  String nidn;
  String foto;
  String email;
  String password;
  String level;
  String fakultas;
  String prodi;

  factory Jurnal.fromJson(Map<String, dynamic> json) => Jurnal(
        id: json["id"],
        idPenelitian: json["id_penelitian"],
        judul: json["judul"],
        no: json["no"],
        volume: json["volume"],
        tahun: json["tahun"],
        tanggal: DateTime.parse(json["tanggal"]),
        skema: json["skema"],
        abstrak: json["abstrak"],
        cover: json["cover"],
        link: json["link"],
        idUser: json["id_user"],
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
        "id": id,
        "id_penelitian": idPenelitian,
        "judul": judul,
        "no": no,
        "volume": volume,
        "tahun": tahun,
        "tanggal": tanggal.toIso8601String(),
        "skema": skema,
        "abstrak": abstrak,
        "cover": cover,
        "link": link,
        "id_user": idUser,
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
