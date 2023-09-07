import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:transport_app/domain/models/trip_model.dart';

import '../../../utils/constants/db_constants.dart';

class TripDB {
  static Box<TripModel> get tripBox => Hive.box<TripModel>(studTrip);

  static int addTrip(TripModel trip) {
    int succes = 0;
    final box = tripBox;
    TripModel? existingTrip;
    try {
      existingTrip = box.values.firstWhere(
        (t) => t.nfcTag == trip.nfcTag,
      );
    } catch (e) {
      print(e);
    }

    if (existingTrip != null) {
      if ((existingTrip.entryStat == trip.entryStat ||
          existingTrip.exitStat == trip.exitStat)) {
        succes = 2;
      } else {
        // Update existing trip if nfcTag already exists
        final index =
            box.keys.firstWhere((key) => box.get(key) == existingTrip);
        trip.entryTime = existingTrip.entryTime;
        trip.entryLat = existingTrip.entryLat;
        trip.entryLong = existingTrip.entryLong;
        trip.entryStat = existingTrip.entryStat;
        trip.lastUpdated = DateTime.now(); // Update last updated timestamp
        log("Trip model ${(trip.toString())}");
        box.putAt(index, trip);
        succes = 3;
      }
    } else {
      // Generate auto-incremented id
      final lastItemId = box.values.isNotEmpty ? box.values.last.id : 0;
      final newId = lastItemId + 1;

      // Set the new id on the trip
      trip.id = newId;
      trip.lastUpdated = DateTime.now(); // Update last updated timestamp
      print("Trip model ${(trip.toString())}");
      // Add new trip if nfcTag does not exist
      box.add(trip);
      succes = 1;
    }
    return succes;
  }

  static clardb() {
    tripBox.clear();
  }

  static List<TripModel> fetchTrips() {
    final box = tripBox;
    List<TripModel> count = [];

    for (final trip in box.values) {
      if (trip.studCode != "") {
        count.add(trip);
      }
    }

    return count;
  }

  static int getCountOfEntryStat() {
    final box = tripBox;
    int count = 0;

    for (final trip in box.values) {
      if (trip.entryStat == '1' &&
          (trip.exitStat == '0' || trip.exitStat == '1')) {
        count++;
      }
    }

    return count;
  }

  static int getCountOfEntryStatException() {
    final box = tripBox;
    int count = 0;

    for (final trip in box.values) {
      if (trip.entryStat == '1' &&
          (trip.exitStat == '0' || trip.exitStat == '1') &&
          trip.studCode == "") {
        count++;
      }
    }

    return count;
  }

  static int getCountOfExitStat() {
    final box = tripBox;
    int count = 0;

    for (final trip in box.values) {
      if ((trip.entryStat == '0' || trip.entryStat == '1') &&
          trip.exitStat == '1') {
        count++;
      }
    }

    return count;
  }

  static int getCountOfExitStatException() {
    final box = tripBox;
    int count = 0;

    for (final trip in box.values) {
      if ((trip.entryStat == '0' || trip.entryStat == '1') &&
          trip.exitStat == '1' &&
          trip.studCode == "") {
        count++;
      }
    }

    return count;
  }

  static TripModel? getLastUpdatedItem() {
    if (tripBox.isEmpty) {
      return null; // Box is empty
    }

    final sortedList = tripBox.values.toList()
      ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));

    return sortedList.first;
  }
}
