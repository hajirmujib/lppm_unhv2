// To parse this JSON data, do
//
//     final detailProposalModel = detailProposalModelFromJson(jsonString);

import 'dart:convert';

DetailProposalModel detailProposalModelFromJson(String str) =>
    DetailProposalModel.fromJson(json.decode(str));

String detailProposalModelToJson(DetailProposalModel data) =>
    json.encode(data.toJson());

class DetailProposalModel {
  DetailProposalModel({
    this.id,
    this.judul,
    this.proposal,
    this.status,
    this.tanggal,
    this.tahun,
    this.jenis,
    this.idUsers,
    this.idReviewer,
    this.rnama,
    this.rnidn,
    this.dnama,
    this.dnidn,
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
  String rnama;
  String rnidn;
  String dnama;
  String dnidn;

  factory DetailProposalModel.fromJson(Map<String, dynamic> json) =>
      DetailProposalModel(
        id: json["id"],
        judul: json["judul"],
        proposal: json["proposal"],
        status: json["status"],
        tanggal: DateTime.parse(json["tanggal"]),
        tahun: json["tahun"],
        jenis: json["jenis"],
        idUsers: json["id_users"],
        idReviewer: json["id_reviewer"],
        rnama: json["Rnama"],
        rnidn: json["Rnidn"],
        dnama: json["Dnama"],
        dnidn: json["Dnidn"],
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
        "Rnama": rnama,
        "Rnidn": rnidn,
        "Dnama": dnama,
        "Dnidn": dnidn,
      };
}
