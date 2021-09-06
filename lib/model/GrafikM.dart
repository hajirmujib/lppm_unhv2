// To parse this JSON data, do
//
//     final grafikM = grafikMFromJson(jsonString);

import 'dart:convert';

GrafikM grafikMFromJson(String str) => GrafikM.fromJson(json.decode(str));

String grafikMToJson(GrafikM data) => json.encode(data.toJson());

class GrafikM {
  GrafikM({
    this.status,
    this.data,
  });

  bool status;
  List<Grafik> data;

  factory GrafikM.fromJson(Map<String, dynamic> json) => GrafikM(
        status: json["status"],
        data: List<Grafik>.from(json["data"].map((x) => Grafik.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Grafik {
  Grafik({
    this.tahun,
    this.jumlah,
  });

  String tahun;
  String jumlah;

  factory Grafik.fromJson(Map<String, dynamic> json) => Grafik(
        tahun: json["tahun"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "tahun": tahun,
        "jumlah": jumlah,
      };
}
