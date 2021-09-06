// To parse this JSON data, do
//
//     final lainyaM = lainyaMFromJson(jsonString);

import 'dart:convert';

LainyaM lainyaMFromJson(String str) => LainyaM.fromJson(json.decode(str));

String lainyaMToJson(LainyaM data) => json.encode(data.toJson());

class LainyaM {
  LainyaM({
    this.status,
    this.data,
  });

  bool status;
  List<Lainya> data;

  factory LainyaM.fromJson(Map<String, dynamic> json) => LainyaM(
        status: json["status"],
        data: List<Lainya>.from(json["data"].map((x) => Lainya.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Lainya {
  Lainya({
    this.id,
    this.idPenelitian,
    this.nama,
    this.keterangan,
    this.file,
    this.tahun,
    this.idUsers,
    this.namaU,
    this.nidn,
    this.foto,
    this.fakultas,
    this.prodi,
    this.email,
    this.level,
  });

  String id;
  String idPenelitian;
  String nama;
  String keterangan;
  String file;
  String tahun;
  String idUsers;
  String namaU;
  String nidn;
  String foto;
  String fakultas;
  String prodi;
  String email;
  String level;

  factory Lainya.fromJson(Map<String, dynamic> json) => Lainya(
        id: json["id"],
        idPenelitian: json["id_penelitian"],
        nama: json["nama"],
        keterangan: json["keterangan"],
        file: json["file"],
        tahun: json["tahun"],
        idUsers: json["id_users"],
        namaU: json["namaU"],
        nidn: json["nidn"],
        foto: json["foto"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        email: json["email"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_penelitian": idPenelitian,
        "nama": nama,
        "keterangan": keterangan,
        "file": file,
        "tahun": tahun,
        "id_users": idUsers,
        "namaU": namaU,
        "nidn": nidn,
        "foto": foto,
        "fakultas": fakultas,
        "prodi": prodi,
        "email": email,
        "level": level,
      };
}
