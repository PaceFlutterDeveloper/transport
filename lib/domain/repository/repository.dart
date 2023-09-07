import 'package:either_dart/either.dart';
import 'package:transport_app/data/resource/remote/api_service.dart';

abstract class Repository {
  Future<Either<ErrorType, dynamic>> addTrip({
    required String tripId,
    required String busNumber,
  });
  Future<Either<ErrorType, dynamic>> fetchStudents({
    required String tripId,
  });
  Future<Either<ErrorType, dynamic>> getBusNumber();
  Future<Either<ErrorType, dynamic>> login({
    required String username,
    required String password,
  });
  Future<Either<ErrorType, dynamic>> startTrip({
    required String tripId,
    required String busNumber,
  });
}
