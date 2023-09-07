// To parse this JSON data, do
//
//     final transportModel = transportModelFromJson(jsonString);

import 'dart:convert';

TransportModel transportModelFromJson(String str) =>
    TransportModel.fromJson(json.decode(str));

String transportModelToJson(TransportModel data) => json.encode(data.toJson());

class Bus {
  final String the0;
  final String the1;
  final String busId;
  final String busNo;

  Bus({
    required this.the0,
    required this.the1,
    required this.busId,
    required this.busNo,
  });

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        the0: json["0"],
        the1: json["1"],
        busId: json["bus_id"],
        busNo: json["bus_no"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "bus_id": busId,
        "bus_no": busNo,
      };
}

class TransportModel {
  final List<Bus> bus;
  final List<Trip> trip;

  TransportModel({
    required this.bus,
    required this.trip,
  });

  factory TransportModel.fromJson(Map<String, dynamic> json) => TransportModel(
        bus: List<Bus>.from(json["bus"].map((x) => Bus.fromJson(x))),
        trip: List<Trip>.from(json["trip"].map((x) => Trip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bus": List<dynamic>.from(bus.map((x) => x.toJson())),
        "trip": List<dynamic>.from(trip.map((x) => x.toJson())),
      };
}

class Trip {
  final String the0;
  final String the1;
  final String tripTypeId;
  final String tripName;

  Trip({
    required this.the0,
    required this.the1,
    required this.tripTypeId,
    required this.tripName,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        the0: json["0"],
        the1: json["1"],
        tripTypeId: json["trip_type_id"],
        tripName: json["trip_name"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "trip_type_id": tripTypeId,
        "trip_name": tripName,
      };
}
