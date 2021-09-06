// To parse this JSON data, do
//
//     final hkiM = hkiMFromJson(jsonString);

import 'dart:convert';

HkiM hkiMFromJson(String str) => HkiM.fromJson(json.decode(str));

String hkiMToJson(HkiM data) => json.encode(data.toJson());

class HkiM {
  HkiM({
    this.status,
    this.data,
  });

  bool status;
  List<HKI> data;

  factory HkiM.fromJson(Map<String, dynamic> json) => HkiM(
        status: json["status"],
        data: List<HKI>.from(json["data"].map((x) => HKI.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HKI {
  HKI({
    this.id,
    this.idPenelitian,
    this.noPermohonan,
    this.tglPermohonan,
    this.nama,
    this.jenisCiptaan,
    this.judulCiptaan,
    this.tglDiumumkan,
    this.tempatDiumumkan,
    this.jangkaWaktu,
    this.noPencatatan,
    this.file,
    this.tahun,
    this.idUsers,
    this.nidn,
    this.level,
    this.fakultas,
    this.prodi,
  });

  String id;
  String idPenelitian;
  String noPermohonan;
  DateTime tglPermohonan;
  String nama;
  String jenisCiptaan;
  String judulCiptaan;
  DateTime tglDiumumkan;
  String tempatDiumumkan;
  String jangkaWaktu;
  String noPencatatan;
  String file;
  String tahun;
  String idUsers;
  String nidn;
  String level;
  String fakultas;
  String prodi;

  factory HKI.fromJson(Map<String, dynamic> json) => HKI(
        id: json["id"],
        idPenelitian: json["id_penelitian"],
        noPermohonan: json["no_permohonan"],
        tglPermohonan: DateTime.parse(json["tgl_permohonan"]),
        nama: json["nama"],
        jenisCiptaan: json["jenis_ciptaan"],
        judulCiptaan: json["judul_ciptaan"],
        tglDiumumkan: DateTime.parse(json["tgl_diumumkan"]),
        tempatDiumumkan: json["tempat_diumumkan"],
        jangkaWaktu: json["jangka_waktu"],
        noPencatatan: json["no_pencatatan"],
        file: json["file"],
        tahun: json["tahun"],
        idUsers: json["id_users"],
        nidn: json["nidn"],
        level: json["level"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_penelitian": idPenelitian,
        "no_permohonan": noPermohonan,
        "tgl_permohonan":
            "${tglPermohonan.year.toString().padLeft(4, '0')}-${tglPermohonan.month.toString().padLeft(2, '0')}-${tglPermohonan.day.toString().padLeft(2, '0')}",
        "nama": nama,
        "jenis_ciptaan": jenisCiptaan,
        "judul_ciptaan": judulCiptaan,
        "tgl_diumumkan":
            "${tglDiumumkan.year.toString().padLeft(4, '0')}-${tglDiumumkan.month.toString().padLeft(2, '0')}-${tglDiumumkan.day.toString().padLeft(2, '0')}",
        "tempat_diumumkan": tempatDiumumkan,
        "jangka_waktu": jangkaWaktu,
        "no_pencatatan": noPencatatan,
        "file": file,
        "tahun": tahun,
        "id_users": idUsers,
        "nidn": nidn,
        "level": level,
        "fakultas": fakultas,
        "prodi": prodi,
      };
}
