// To parse this JSON data, do
//
//     final tahunModel = tahunModelFromJson(jsonString);

import 'dart:convert';

TahunModel tahunModelFromJson(String str) =>
    TahunModel.fromJson(json.decode(str));

String tahunModelToJson(TahunModel data) => json.encode(data.toJson());

class TahunModel {
  TahunModel({
    this.status,
    this.data,
  });

  bool status;
  List<Tahun> data;

  factory TahunModel.fromJson(Map<String, dynamic> json) => TahunModel(
        status: json["status"],
        data: List<Tahun>.from(json["data"].map((x) => Tahun.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Tahun {
  Tahun({
    this.id,
    this.tahun,
    this.status,
  });

  String id;
  String tahun;
  String status;

  factory Tahun.fromJson(Map<String, dynamic> json) => Tahun(
        id: json["id"],
        tahun: json["tahun"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tahun": tahun,
        "status": status,
      };
}
