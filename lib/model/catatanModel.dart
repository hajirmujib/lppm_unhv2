// To parse this JSON data, do
//
//     final catatanM = catatanMFromJson(jsonString);

import 'dart:convert';

CatatanM catatanMFromJson(String str) => CatatanM.fromJson(json.decode(str));

String catatanMToJson(CatatanM data) => json.encode(data.toJson());

class CatatanM {
  CatatanM({
    this.status,
    this.data,
  });

  bool status;
  List<CatatanHarian> data;

  factory CatatanM.fromJson(Map<String, dynamic> json) => CatatanM(
        status: json["status"],
        data: List<CatatanHarian>.from(
            json["data"].map((x) => CatatanHarian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CatatanHarian {
  CatatanHarian({
    this.idFile,
    this.idPenelitian,
    this.file,
    this.tanggal,
    this.keterangan,
    this.idUser,
  });

  String idFile;
  String idPenelitian;
  String file;
  DateTime tanggal;
  String keterangan;
  String idUser;

  factory CatatanHarian.fromJson(Map<String, dynamic> json) => CatatanHarian(
        idFile: json["id_file"],
        idPenelitian: json["id_penelitian"],
        file: json["file"],
        tanggal: DateTime.parse(json["tanggal"]),
        keterangan: json["keterangan"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_file": idFile,
        "id_penelitian": idPenelitian,
        "file": file,
        "tanggal": tanggal.toIso8601String(),
        "keterangan": keterangan,
        "id_user": idUser,
      };
}
