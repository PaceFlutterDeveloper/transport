import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/data/resource/local/local_db.dart';
import 'package:transport_app/data/resource/remote/api_service.dart';
import 'package:transport_app/data/resource/remote/data_state.dart';
import 'package:transport_app/data/resource/remote/dependancy_injection.dart';
import 'package:transport_app/domain/models/transport_model.dart';
import 'package:transport_app/domain/repository/repository.dart';
import 'package:transport_app/utils/constants/db_constants.dart';

import 'nfc_provider.dart';

class TransportProvider with ChangeNotifier {
  final Repository _repository = locator<Repository>();

  late TransportModel _transportModel;
  ResDataState getBusDataState =
      ResDataState(dataState: DataState.Uninitialized);
  ResDataState startTripState =
      ResDataState(dataState: DataState.Uninitialized);
  Bus? selectedBus;
  Trip? selectedTrip;

  final Location location = Location();
  late Box tripDataBox;
  late StreamSubscription<LocationData> locationSubscription;
  TransportProvider() {
    tripDataBox = Hive.box('trip_data');
  }
  TransportModel get transportModel => _transportModel;

  //get bus and trip mode by passing the phone imei number
  getBuses() async {
    getBusDataState = ResDataState(dataState: DataState.Loading);
    var res = await _repository.getBusNumber();
    if (res.isLeft) {
      ErrorType errorType = res.left;
      getBusDataState = ResDataState(
          dataState: DataState.Error, message: errorType.toString());
    } else {
      if (res.right == null) {
        getBusDataState = ResDataState(dataState: DataState.NoData);
      } else {
        _transportModel = TransportModel.fromJson(jsonDecode(res.right));
        getBusDataState = ResDataState(dataState: DataState.Loaded);
      }
    }
    notifyListeners();
  }

  locationDataCollection() async {
    locationSubscription = location.onLocationChanged.listen((locationData) {
      final tripPoint = {
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        "bus_id": selectedBus!.busId,
        'timestamp': DateTime.now().toUtc().toString(),
      };
      tripDataBox.add(tripPoint);
    });
  }

  setBus(Bus bus) {
    selectedBus = bus;
    notifyListeners();
  }

  setTrip(Trip trip) {
    selectedTrip = trip;
    notifyListeners();
  }

  startTrip(context) async {
    startTripState = ResDataState(dataState: DataState.Loading);
    var res = await _repository.startTrip(
        busNumber: selectedBus!.busNo, tripId: selectedTrip!.tripTypeId);
    if (res.isLeft) {
      ErrorType errorType = res.left;
      startTripState = ResDataState(
          dataState: DataState.Error, message: errorType.toString());
    } else {
      if (res.right == null) {
        startTripState = ResDataState(dataState: DataState.NoData);
      } else {
        log("Response ${res.right}");
        addTripId(busId, selectedBus!.busId);
        addTripId(tripName, selectedTrip!.tripTypeId);
        addTripId(tripId, res.right);
        selectedTrip = null;
        selectedBus = null;
        Provider.of<NfcProvider>(context, listen: false)
            .listenForNFCEvents(context);
        _repository.fetchStudents(tripId: res.right);

        startTripState = ResDataState(dataState: DataState.Loaded);
      }
    }
    notifyListeners();
  }

  stopTrip() {
    locationSubscription.cancel();
  }
}
