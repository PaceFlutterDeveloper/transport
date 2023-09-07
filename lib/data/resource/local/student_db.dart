import 'package:hive/hive.dart';
import 'package:transport_app/utils/constants/db_constants.dart';

import '../../../domain/models/students_model.dart';

class StudentDb {
  static Box<Student> get studentBox => Hive.box<Student>(students);

  static void addStudent(Student student) {
    final box = studentBox;
    box.add(student);
  }

  static clardb() {
    studentBox.clear();
  }

  static List<Student> fetchAllStudents() {
    final box = studentBox;
    return box.values.toList();
  }

  static Student? getStudentByNfcTag(String nfcTag) {
    final box = studentBox;
    try {
      return box.values.firstWhere((student) => student.nfcTag == nfcTag);
    } catch (e) {
      // showToast("No Student found");
      print('Student not found: $e');
      return null;
    }
  }
}
