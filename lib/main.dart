import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transport_app/data/resource/remote/dependancy_injection.dart';
import 'package:transport_app/domain/models/students_model.dart';
import 'package:transport_app/domain/models/trip_model.dart';
import 'package:transport_app/utils/constants/db_constants.dart';
import 'package:transport_app/utils/extensions/location_permission.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox(tripDb);
  Hive.registerAdapter<Student>(StudentAdapter());
  await Hive.openBox<Student>(students);
  Hive.registerAdapter<TripModel>(TripModelAdapter());
  await Hive.openBox<TripModel>(studTrip);
  await Hive.openBox('trip_data');

  // Initialize dependencies
  serviceLocators();
  getPermission();
  runApp(const MyApp());
}
