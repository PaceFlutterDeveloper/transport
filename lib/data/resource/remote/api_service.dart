// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Either<ErrorType, dynamic>> getRequest(String url) async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return const Left(ErrorType.ServerError);
      }
    } catch (e) {
      return const Left(ErrorType.InternetError);
    }
  }

  Future<Either<ErrorType, dynamic>> postRequest(
      String url, dynamic data) async {
    try {
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response.data);
      } else {
        return const Left(ErrorType.ServerError);
      }
    } catch (e) {
      return const Left(ErrorType.InternetError);
    }
  }
}

enum ErrorType {
  InternetError,
  ServerError,
}
