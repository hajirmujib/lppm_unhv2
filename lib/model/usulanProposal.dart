// To parse this JSON data, do
//
//     final usulanProposalModel = usulanProposalModelFromJson(jsonString);

import 'dart:convert';

UsulanProposalModel usulanProposalModelFromJson(String str) =>
    UsulanProposalModel.fromJson(json.decode(str));

String usulanProposalModelToJson(UsulanProposalModel data) =>
    json.encode(data.toJson());

class UsulanProposalModel {
  UsulanProposalModel({
    this.status,
    this.data,
  });

  bool status;
  List<UsulanProposal> data;

  factory UsulanProposalModel.fromJson(Map<String, dynamic> json) =>
      UsulanProposalModel(
        status: json["status"],
        data: List<UsulanProposal>.from(
            json["data"].map((x) => UsulanProposal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UsulanProposal {
  UsulanProposal({
    this.id,
    this.judul,
    this.proposal,
    this.status,
    this.tanggal,
    this.tahun,
    this.jenis,
    this.idUsers,
    this.idReviewer,
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
  String judul;
  String proposal;
  String status;
  DateTime tanggal;
  String tahun;
  String jenis;
  String idUsers;
  String idReviewer;
  String nama;
  String nidn;
  String foto;
  String email;
  String password;
  String level;
  String fakultas;
  String prodi;

  factory UsulanProposal.fromJson(Map<String, dynamic> json) => UsulanProposal(
        id: json["id"],
        judul: json["judul"],
        proposal: json["proposal"],
        status: json["status"],
        tanggal: DateTime.parse(json["tanggal"]),
        tahun: json["tahun"],
        jenis: json["jenis"],
        idUsers: json["id_users"],
        idReviewer: json["id_reviewer"],
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
        "judul": judul,
        "proposal": proposal,
        "status": status,
        "tanggal": tanggal.toIso8601String(),
        "tahun": tahun,
        "jenis": jenis,
        "id_users": idUsers,
        "id_reviewer": idReviewer,
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
