// To parse this JSON data, do
//
//     final patenM = patenMFromJson(jsonString);

import 'dart:convert';

PatenM patenMFromJson(String str) => PatenM.fromJson(json.decode(str));

String patenMToJson(PatenM data) => json.encode(data.toJson());

class PatenM {
  PatenM({
    this.status,
    this.data,
  });

  bool status;
  List<Paten> data;

  factory PatenM.fromJson(Map<String, dynamic> json) => PatenM(
        status: json["status"],
        data: List<Paten>.from(json["data"].map((x) => Paten.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Paten {
  Paten({
    this.id,
    this.idPenelitian,
    this.tglPengajuan,
    this.noPermohonan,
    this.pemohon,
    this.judulInvensi,
    this.file,
    this.tahun,
    this.idUsers,
    this.nama,
    this.nidn,
    this.level,
    this.fakultas,
    this.prodi,
  });

  String id;
  String idPenelitian;
  DateTime tglPengajuan;
  String noPermohonan;
  String pemohon;
  String judulInvensi;
  String file;
  String tahun;
  String idUsers;
  String nama;
  String nidn;
  String level;
  String fakultas;
  String prodi;

  factory Paten.fromJson(Map<String, dynamic> json) => Paten(
        id: json["id"],
        idPenelitian: json["id_penelitian"],
        tglPengajuan: DateTime.parse(json["tgl_pengajuan"]),
        noPermohonan: json["no_permohonan"],
        pemohon: json["pemohon"],
        judulInvensi: json["judul_invensi"],
        file: json["file"],
        tahun: json["tahun"],
        idUsers: json["id_users"],
        nama: json["nama"],
        nidn: json["nidn"],
        level: json["level"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_penelitian": idPenelitian,
        "tgl_pengajuan":
            "${tglPengajuan.year.toString().padLeft(4, '0')}-${tglPengajuan.month.toString().padLeft(2, '0')}-${tglPengajuan.day.toString().padLeft(2, '0')}",
        "no_permohonan": noPermohonan,
        "pemohon": pemohon,
        "judul_invensi": judulInvensi,
        "file": file,
        "tahun": tahun,
        "id_users": idUsers,
        "nama": nama,
        "nidn": nidn,
        "level": level,
        "fakultas": fakultas,
        "prodi": prodi,
      };
}
