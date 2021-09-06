// To parse this JSON data, do
//
//     final artikelModel = artikelModelFromJson(jsonString);

import 'dart:convert';

ArtikelModel artikelModelFromJson(String str) =>
    ArtikelModel.fromJson(json.decode(str));

String artikelModelToJson(ArtikelModel data) => json.encode(data.toJson());

class ArtikelModel {
  ArtikelModel({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory ArtikelModel.fromJson(Map<String, dynamic> json) => ArtikelModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.idAtk,
    this.atkJudul,
    this.atkIsi,
    this.atkTanggal,
    this.file,
  });

  String idAtk;
  String atkJudul;
  String atkIsi;
  DateTime atkTanggal;
  String file;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idAtk: json["id_atk"],
        atkJudul: json["atk_judul"],
        atkIsi: json["atk_isi"],
        atkTanggal: DateTime.parse(json["atk_tanggal"]),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id_atk": idAtk,
        "atk_judul": atkJudul,
        "atk_isi": atkIsi,
        "atk_tanggal": atkTanggal.toIso8601String(),
        "file": file,
      };
}
