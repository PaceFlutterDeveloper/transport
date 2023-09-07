import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transport_app/utils/constants/db_constants.dart';

final HiveInterface hive = GetIt.instance<HiveInterface>();
addTripId(String key, String tripId) {
  final Box tripBox = hive.box(tripDb);

  tripBox.put(key, tripId);
}

clearData() {
  final Box tripBox = hive.box(tripDb);
  tripBox.clear();
}
