import 'dart:convert';

class BookingModel {
  int? id;
  String? orderName;
  DateTime? date;
  String? hours;
  String? payment;
  int? orderId;
  int? bookingId;
  Order? order;
  LapanganBooking? lapangan;
  String? image;
  String? confirmation;

  BookingModel(
      {this.id,
      this.orderName,
      this.date,
      this.hours,
      this.payment,
      this.orderId,
      this.bookingId,
      this.order,
      this.lapangan,
      this.image,
      this.confirmation});

  factory BookingModel.fromRawJson(String str) =>
      BookingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        orderName: json["orderName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        hours: json["hours"],
        payment: json["payment"],
        orderId: json["orderId"],
        bookingId: json["bookingId"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        lapangan: json["lapangan"] == null
            ? null
            : LapanganBooking.fromJson(json["lapangan"]),
        image: json["image"],
        confirmation: json["confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderName": orderName,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "hours": hours,
        "payment": payment,
        "orderId": orderId,
        "bookingId": bookingId,
        "order": order?.toJson(),
        "lapangan": lapangan?.toJson(),
        "image": image,
        "confirmation": confirmation,
      };
}

class LapanganBooking {
  int? id;
  String? nameVenue;
  String? nameLapangan;
  DateTime? days;
  String? availableHour;
  String? unavailableHour;
  int? lapanganId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  LapanganBooking({
    this.id,
    this.nameVenue,
    this.nameLapangan,
    this.days,
    this.availableHour,
    this.unavailableHour,
    this.lapanganId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory LapanganBooking.fromRawJson(String str) =>
      LapanganBooking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LapanganBooking.fromJson(Map<String, dynamic> json) =>
      LapanganBooking(
        id: json["id"],
        nameVenue: json["nameVenue"],
        nameLapangan: json["nameLapangan"],
        days: json["days"] == null ? null : DateTime.parse(json["days"]),
        availableHour: json["availableHour"],
        unavailableHour: json["unavailableHour"],
        lapanganId: json["lapanganId"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameVenue": nameVenue,
        "nameLapangan": nameLapangan,
        "days":
            "${days!.year.toString().padLeft(4, '0')}-${days!.month.toString().padLeft(2, '0')}-${days!.day.toString().padLeft(2, '0')}",
        "availableHour": availableHour,
        "unavailableHour": unavailableHour,
        "lapanganId": lapanganId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Order {
  int? id;
  String? name;
  String? email;
  String? phone;

  Order({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      };
}
