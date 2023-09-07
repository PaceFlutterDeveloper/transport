import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transport_app/domain/models/trip_model.dart';

import '../../data/resource/local/student_db.dart';
import '../../utils/constants/db_constants.dart';
import '../pages/Students/student_list.dart';

class AllStudentComponent extends StatelessWidget {
  const AllStudentComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TripModel>(studTrip).listenable(),
        builder: (BuildContext context, Box value, Widget? child) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentListPage(),
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffededed),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/stud.png",
                          height: 50,
                          // height: MediaQuery.of(context).size.height * 0.08,
                          // width: MediaQuery.of(context).size.height * 0.08,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${StudentDb.fetchAllStudents().length} Students",
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "View",
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                                const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 13,
                          color: Colors.blue,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
