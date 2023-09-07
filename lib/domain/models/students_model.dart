import 'package:hive/hive.dart';

part 'students_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late String studCode;

  @HiveField(1)
  late String studName;

  @HiveField(2)
  late String grade;

  @HiveField(3)
  late String nfcTag;

  @HiveField(4)
  late int lastAttendance;

  Student({
    required this.studCode,
    required this.studName,
    required this.grade,
    required this.nfcTag,
    required this.lastAttendance,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studCode: json['STUDCODE'].toString(),
      studName: json['STUDNAME'].toString(),
      grade: json['GR'].toString(),
      nfcTag: json['NFC_TAG'].toString(),
      lastAttendance: int.parse(json['LAST_ATT'].toString()),
    );
  }
}
