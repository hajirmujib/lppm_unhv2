// To parse this JSON data, do
//
//     final komentarProposalM = komentarProposalMFromJson(jsonString);

import 'dart:convert';

KomentarProposalM komentarProposalMFromJson(String str) =>
    KomentarProposalM.fromJson(json.decode(str));

String komentarProposalMToJson(KomentarProposalM data) =>
    json.encode(data.toJson());

class KomentarProposalM {
  KomentarProposalM({
    this.status,
    this.data,
  });

  bool status;
  List<KomentarProposal> data;

  factory KomentarProposalM.fromJson(Map<String, dynamic> json) =>
      KomentarProposalM(
        status: json["status"],
        data: List<KomentarProposal>.from(
            json["data"].map((x) => KomentarProposal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KomentarProposal {
  KomentarProposal({
    this.idKomentar,
    this.idProposal,
    this.isi,
    this.tanggal,
    this.idUsers,
    this.nama,
    this.level,
  });

  String idKomentar;
  String idProposal;
  String isi;
  DateTime tanggal;
  String idUsers;
  String nama;
  String level;

  factory KomentarProposal.fromJson(Map<String, dynamic> json) =>
      KomentarProposal(
        idKomentar: json["id_komentar"],
        idProposal: json["id_proposal"],
        isi: json["isi"],
        tanggal: DateTime.parse(json["tanggal"]),
        idUsers: json["id_users"],
        nama: json["nama"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id_komentar": idKomentar,
        "id_proposal": idProposal,
        "isi": isi,
        "tanggal": tanggal.toIso8601String(),
        "id_users": idUsers,
        "nama": nama,
        "level": level,
      };
}
