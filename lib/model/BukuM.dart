// To parse this JSON data, do
//
//     final bukuM = bukuMFromJson(jsonString);

import 'dart:convert';

BukuM bukuMFromJson(String str) => BukuM.fromJson(json.decode(str));

String bukuMToJson(BukuM data) => json.encode(data.toJson());

class BukuM {
  BukuM({
    this.status,
    this.data,
  });

  bool status;
  List<Buku> data;

  factory BukuM.fromJson(Map<String, dynamic> json) => BukuM(
        status: json["status"],
        data: List<Buku>.from(json["data"].map((x) => Buku.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Buku {
  Buku({
    this.id,
    this.idPenelitian,
    this.judul,
    this.pengarang,
    this.penerbit,
    this.ketebalan,
    this.tahunTerbit,
    this.noEdisi,
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
  String judul;
  String pengarang;
  String penerbit;
  String ketebalan;
  String tahunTerbit;
  String noEdisi;
  String file;
  String tahun;
  String idUsers;
  String nama;
  String nidn;
  String level;
  String fakultas;
  String prodi;

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        id: json["id"],
        idPenelitian: json["id_penelitian"],
        judul: json["judul"],
        pengarang: json["pengarang"],
        penerbit: json["penerbit"],
        ketebalan: json["ketebalan"],
        tahunTerbit: json["tahun_terbit"],
        noEdisi: json["no_edisi"],
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
        "judul": judul,
        "pengarang": pengarang,
        "penerbit": penerbit,
        "ketebalan": ketebalan,
        "tahun_terbit": tahunTerbit,
        "no_edisi": noEdisi,
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
