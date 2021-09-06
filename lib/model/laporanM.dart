// To parse this JSON data, do
//
//     final laporanM = laporanMFromJson(jsonString);

import 'dart:convert';

LaporanM laporanMFromJson(String str) => LaporanM.fromJson(json.decode(str));

String laporanMToJson(LaporanM data) => json.encode(data.toJson());

class LaporanM {
  LaporanM({
    this.status,
    this.data,
  });

  bool status;
  List<Laporan> data;

  factory LaporanM.fromJson(Map<String, dynamic> json) => LaporanM(
        status: json["status"],
        data: List<Laporan>.from(json["data"].map((x) => Laporan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Laporan {
  Laporan({
    this.id,
    this.idPenelitian,
    this.file,
    this.jenis,
    this.idUsers,
  });

  String id;
  String idPenelitian;
  String file;
  String jenis;
  String idUsers;

  factory Laporan.fromJson(Map<String, dynamic> json) => Laporan(
        id: json["id"],
        idPenelitian: json["id_penelitian"],
        file: json["file"],
        jenis: json["jenis"],
        idUsers: json["id_users"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_penelitian": idPenelitian,
        "file": file,
        "jenis": jenis,
        "id_users": idUsers,
      };
}
