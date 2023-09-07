// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/config/theme/color_constants.dart';
import 'package:transport_app/data/resource/local/trip_db.dart';
import 'package:transport_app/domain/models/trip_model.dart';
import 'package:transport_app/utils/constants/db_constants.dart';

class MarkAttendanceScreen extends StatelessWidget {
  const MarkAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Mark Attendance",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // const InOutButton(),
            ValueListenableBuilder(
                valueListenable: Hive.box<TripModel>(studTrip).listenable(),
                builder: (BuildContext context, Box value, Widget? child) {
                  return ListView.builder(
                    itemCount: TripDB.fetchTrips().length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      TripModel tripModel = TripDB.fetchTrips()[index];
                      return Card(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${tripModel.name}"),
                              Text("Admn No : ${tripModel.studCode}"),
                            ],
                          ),

                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "IN: ${DateFormat('h:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(tripModel.entryTime.toString()))}",
                                style: TextStyle(
                                    color: tripModel.exitTime == ''
                                        ? null
                                        : ColorConstants.green),
                              ),
                              tripModel.exitTime == ''
                                  ? const Text("Out not marked")
                                  : Text(
                                      "OUT: ${DateFormat('h:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(tripModel.entryTime.toString()))}",
                                      style: TextStyle(
                                          color: tripModel.exitTime == ''
                                              ? null
                                              : ColorConstants.red),
                                    ),
                            ],
                          ),
                          //  trailing: Text("Stud Code ${tripModel.nfcTag}"),
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      )),
    );
  }
}

class StudentTileAttendance extends StatelessWidget {
  final TripModel tripModel;
  const StudentTileAttendance({
    Key? key,
    required this.tripModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${tripModel.name}"),
            Text("Admn No : ${tripModel.studCode}"),
          ],
        ),

        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            tripModel.entryTime == ''
                ? const Text("In not marked")
                : Text(
                    "IN: ${DateFormat('h:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(tripModel.entryTime.toString()))}",
                    style: TextStyle(
                        color: tripModel.exitTime == ''
                            ? null
                            : ColorConstants.green),
                  ),
            tripModel.exitTime == ''
                ? const Text("Out not marked")
                : Text(
                    "OUT: ${DateFormat('h:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(tripModel.exitTime.toString()))}",
                    style: TextStyle(
                        color: tripModel.exitTime == ''
                            ? null
                            : ColorConstants.red),
                  ),
          ],
        ),
        //  trailing: Text("Stud Code ${tripModel.nfcTag}"),
      ),
    );
  }
}
