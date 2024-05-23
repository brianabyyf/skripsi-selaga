import 'dart:convert';

class LapanganModel {
  int id;
  String? venue;
  String name;
  String? image;
  String address;
  String price;
  String decs;
  String? timetableDays;
  String? timetableHours;
  int mitraId;

  LapanganModel({
    required this.id,
    required this.venue,
    required this.name,
    required this.image,
    required this.address,
    required this.price,
    required this.decs,
    required this.timetableDays,
    required this.timetableHours,
    required this.mitraId,
  });

  factory LapanganModel.fromRawJson(String str) =>
      LapanganModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LapanganModel.fromJson(Map<String, dynamic> json) => LapanganModel(
        id: json["id"],
        venue: json["venue"],
        name: json["name"],
        image: json["image"],
        address: json["address"],
        price: json["price"],
        decs: json["decs"],
        timetableDays: json["timetableDays"],
        timetableHours: json["timetableHours"],
        mitraId: json["mitraId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue": venue,
        "name": name,
        "image": image,
        "address": address,
        "price": price,
        "decs": decs,
        "timetableDays": timetableDays,
        "timetableHours": timetableHours,
        "mitraId": mitraId,
      };
}
