// To parse this JSON data, do
//
//     final komentarPenelitianM = komentarPenelitianMFromJson(jsonString);

import 'dart:convert';

KomentarPenelitianM komentarPenelitianMFromJson(String str) =>
    KomentarPenelitianM.fromJson(json.decode(str));

String komentarPenelitianMToJson(KomentarPenelitianM data) =>
    json.encode(data.toJson());

class KomentarPenelitianM {
  KomentarPenelitianM({
    this.status,
    this.data,
  });

  bool status;
  List<KomentarPenelitian> data;

  factory KomentarPenelitianM.fromJson(Map<String, dynamic> json) =>
      KomentarPenelitianM(
        status: json["status"],
        data: List<KomentarPenelitian>.from(
            json["data"].map((x) => KomentarPenelitian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KomentarPenelitian {
  KomentarPenelitian({
    this.idKomentar,
    this.idKegiatan,
    this.isi,
    this.tanggal,
    this.idUsers,
    this.nama,
    this.level,
  });

  String idKomentar;
  String idKegiatan;
  String isi;
  DateTime tanggal;
  String idUsers;
  String nama;
  String level;

  factory KomentarPenelitian.fromJson(Map<String, dynamic> json) =>
      KomentarPenelitian(
        idKomentar: json["id_komentar"],
        idKegiatan: json["id_kegiatan"],
        isi: json["isi"],
        tanggal: DateTime.parse(json["tanggal"]),
        idUsers: json["id_users"],
        nama: json["nama"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id_komentar": idKomentar,
        "id_kegiatan": idKegiatan,
        "isi": isi,
        "tanggal": tanggal.toIso8601String(),
        "id_users": idUsers,
        "nama": nama,
        "level": level,
      };
}
