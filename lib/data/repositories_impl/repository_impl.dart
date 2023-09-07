import 'dart:convert';
import 'dart:developer';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:transport_app/data/resource/local/student_db.dart';
import 'package:transport_app/data/resource/remote/api_service.dart';
import 'package:transport_app/domain/models/students_model.dart';
import 'package:transport_app/domain/repository/repository.dart';
import 'package:transport_app/utils/constants/api_constant.dart';
import 'package:transport_app/utils/extensions/device_info_extension.dart';

import '../../utils/extensions/current_date.dart';

class RepositoryImpl extends Repository {
  final ApiService apiService;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  RepositoryImpl(this.apiService);

  @override
  Future<Either<ErrorType, dynamic>> addTrip(
      {required String tripId, required String busNumber}) {
    // TODO: implement addTrip
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorType, dynamic>> fetchStudents(
      {required String tripId}) async {
    var response =
        await apiService.getRequest(ApiConstants.getStudents + tripId);

    if (response.isLeft) {
      return Left(response.left);
    } else {
      log("Response \n ${jsonDecode(response.right)}");
      for (var item in jsonDecode(response.right)) {
        StudentDb.addStudent(Student.fromJson(item));
      }
      return Right(response.right);
    }
  }

  @override
  Future<Either<ErrorType, dynamic>> getBusNumber() async {
    String iemiNumber = await _deviceInfo.getImeiNumber();
    var response =
        await apiService.getRequest(ApiConstants.getBuses + iemiNumber);

    if (response.isLeft) {
      return Left(response.left);
    } else {
      return Right(response.right);
    }
  }

  @override
  Future<Either<ErrorType, dynamic>> login({
    required String username,
    required String password,
  }) async {
    // Create FormData object and add form fields
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    if (kDebugMode) {
      print('Form Data:');
    }
    for (MapEntry<String, dynamic> entry in formData.fields) {
      if (kDebugMode) {
        print('${entry.key}: ${entry.value}');
      }
    }

    var response = await apiService.postRequest(ApiConstants.login, formData);

    if (response.isLeft) {
      log("Login error \n${jsonEncode(response.left)}");
      return Left(response.left);
    } else {
      log("Login response \n${jsonEncode(response.right)}");
      return Right(response.right);
    }
  }

  @override
  Future<Either<ErrorType, dynamic>> startTrip(
      {required String tripId, required String busNumber}) async {
    // Create FormData object and add form fields
    FormData formData = FormData.fromMap({
      'page': 'startTrip',
      'ACTION': 'START',
      'IMEI': BigInt.parse(await _deviceInfo.getImeiNumber(), radix: 16),
      'BUS_NO': busNumber,
      'START_TIME': currentDateTime(),
      'TRIP_TYPE': tripId,
    });
    if (kDebugMode) {
      print('Form Data:');
    }
    for (MapEntry<String, dynamic> entry in formData.fields) {
      if (kDebugMode) {
        print('${entry.key}: ${entry.value}');
      }
    }

    var response =
        await apiService.postRequest(ApiConstants.startTrip, formData);

    if (response.isLeft) {
      return Left(response.left);
    } else {
      return Right(response.right);
    }
  }
}
