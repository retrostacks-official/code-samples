// To parse this JSON data, do
//
//     final bookingGqlInput = bookingGqlInputFromJson(jsonString);

import 'dart:convert';

BookingGqlInput bookingGqlInputFromJson(String str) => BookingGqlInput.fromJson(json.decode(str));

String bookingGqlInputToJson(BookingGqlInput data) => json.encode(data.toJson());

class BookingGqlInput {
  final String addressId;
  final String message;
  final Service service;
  final String couponCode;
  final String alternatePhoneNumber;
  final double redeemPoints;

  BookingGqlInput({
    required this.addressId,
    required this.message,
    required this.service,
    required this.couponCode,
    required this.alternatePhoneNumber,
    required this.redeemPoints,
  });

  factory BookingGqlInput.fromJson(Map<String, dynamic> json) => BookingGqlInput(
    addressId: json["addressId"],
    message: json["message"],
    service: Service.fromJson(json["service"]),
    couponCode: json["couponCode"],
    alternatePhoneNumber: json["alternatePhoneNumber"],
    redeemPoints: json["redeemPoints"],
  );

  Map<String, dynamic> toJson() => {
    "addressId": addressId,
    "message": message,
    "service": service.toJson(),
    "couponCode": couponCode,
    "alternatePhoneNumber": alternatePhoneNumber,
    "redeemPoints": redeemPoints,
  };
}

class Service {
  final String serviceBillingOptionId;
  final int units;
  final DateTime startDateTime;
  final DateTime endDateTime;

  Service({
    required this.serviceBillingOptionId,
    required this.units,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceBillingOptionId: json["serviceBillingOptionId"],
    units: json["units"],
    startDateTime: DateTime.parse(json["startDateTime"]),
    endDateTime: DateTime.parse(json["endDateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "serviceBillingOptionId": serviceBillingOptionId,
    "units": units,
    "startDateTime": startDateTime.toIso8601String(),
    "endDateTime": endDateTime.toIso8601String(),
  };
}
