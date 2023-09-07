import 'package:hive/hive.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 1)
class TripModel extends HiveObject {
  @HiveField(0)
  late String tripId;

  @HiveField(1)
  late int id;

  @HiveField(2)
  late String nfcTag;

  @HiveField(3)
  late String studCode;

  @HiveField(4)
  late String entryTime;

  @HiveField(5)
  late String exitTime;

  @HiveField(6)
  late String entryStat;

  @HiveField(7)
  late String exitStat;

  @HiveField(8)
  late double entryLat;

  @HiveField(9)
  late double entryLong;

  @HiveField(10)
  late double exitLat;

  @HiveField(11)
  late double exitLong;

  @HiveField(12)
  late String? name;
  @HiveField(13)
  late DateTime lastUpdated; // Add a "last updated" field

  TripModel(
      {required this.tripId,
      required this.id,
      required this.nfcTag,
      required this.studCode,
      required this.entryTime,
      required this.exitTime,
      required this.entryStat,
      required this.exitStat,
      required this.entryLat,
      required this.entryLong,
      required this.exitLat,
      required this.exitLong,
      required this.lastUpdated,
      this.name});

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['TRIP_ID'] as String,
      id: json['ID'] as int,
      nfcTag: json['NFC_TAG'] as String,
      studCode: json['STUDCODE'] as String,
      entryTime: json['ENTRY_TIME'] as String,
      exitTime: json['EXIT_TIME'] as String,
      entryStat: json['ENTRY_STAT'] as String,
      exitStat: json['EXIT_STAT'] as String,
      entryLat: json['ENTRY_LAT'] as double,
      entryLong: json['ENTRY_LONG'] as double,
      exitLat: json['EXIT_LAT'] as double,
      exitLong: json['EXIT_LONG'] as double,
      lastUpdated: DateTime.parse(json['LAST_UPDATED'] as String),
    );
  }

  @override
  String toString() {
    return 'TripModel(tripId: $tripId, id: $id, nfcTag: $nfcTag, studCode: $studCode, entryTime: $entryTime, exitTime: $exitTime, entryStat: $entryStat, exitStat: $exitStat, entryLat: $entryLat, entryLong: $entryLong, exitLat: $exitLat, exitLong: $exitLong, name: $name, lastUpdated: $lastUpdated)';
  }
}
