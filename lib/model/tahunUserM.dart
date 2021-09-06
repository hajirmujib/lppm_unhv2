// To parse this JSON data, do
//
//     final tahunUserM = tahunUserMFromJson(jsonString);

import 'dart:convert';

TahunUserM tahunUserMFromJson(String str) =>
    TahunUserM.fromJson(json.decode(str));

String tahunUserMToJson(TahunUserM data) => json.encode(data.toJson());

class TahunUserM {
  TahunUserM({
    this.status,
    this.data,
  });

  bool status;
  List<TahunUser> data;

  factory TahunUserM.fromJson(Map<String, dynamic> json) => TahunUserM(
        status: json["status"],
        data: List<TahunUser>.from(
            json["data"].map((x) => TahunUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TahunUser {
  TahunUser({
    this.tahun,
  });

  String tahun;

  factory TahunUser.fromJson(Map<String, dynamic> json) => TahunUser(
        tahun: json["tahun"],
      );

  Map<String, dynamic> toJson() => {
        "tahun": tahun,
      };
}
