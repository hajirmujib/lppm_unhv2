// To parse this JSON data, do
//
//     final informasiModel = informasiModelFromJson(jsonString);

import 'dart:convert';

InformasiModel informasiModelFromJson(String str) =>
    InformasiModel.fromJson(json.decode(str));

String informasiModelToJson(InformasiModel data) => json.encode(data.toJson());

class InformasiModel {
  InformasiModel({
    this.status,
    this.data,
  });

  bool status;
  List<Informasi> data;

  factory InformasiModel.fromJson(Map<String, dynamic> json) => InformasiModel(
        status: json["status"],
        data: List<Informasi>.from(
            json["data"].map((x) => Informasi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Informasi {
  Informasi({
    this.idInfo,
    this.infoJudul,
    this.infoIsi,
    this.infoTanggal,
    this.lampiran,
  });

  String idInfo;
  String infoJudul;
  String infoIsi;
  DateTime infoTanggal;
  String lampiran;

  factory Informasi.fromJson(Map<String, dynamic> json) => Informasi(
        idInfo: json["id_info"],
        infoJudul: json["info_judul"],
        infoIsi: json["info_isi"],
        infoTanggal: DateTime.parse(json["info_tanggal"]),
        lampiran: json["lampiran"],
      );

  Map<String, dynamic> toJson() => {
        "id_info": idInfo,
        "info_judul": infoJudul,
        "info_isi": infoIsi,
        "info_tanggal": infoTanggal.toIso8601String(),
        "lampiran": lampiran,
      };
}
