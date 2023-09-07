import 'package:flutter/material.dart';
import 'package:transport_app/data/resource/local/student_db.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Student List',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StudentDb.fetchAllStudents().isEmpty
              ? const Center(
                  child: Text("No Students Found"),
                )
              : ListView.builder(
                  itemCount: StudentDb.fetchAllStudents().length,
                  itemBuilder: (context, index) {
                    final student = StudentDb.fetchAllStudents()[index];
                    return Card(
                      child: ListTile(
                        title: Text(student.studName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Grade & Sec : ${student.grade}"),
                            Text("Admn No : ${student.studCode}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}
