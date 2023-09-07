import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transport_app/data/repositories_impl/repository_impl.dart';
import 'package:transport_app/domain/repository/repository.dart';

import 'api_service.dart';

GetIt locator = GetIt.instance;

void serviceLocators() {
  final dio = Dio();

  locator.registerSingleton<Dio>(dio);
  locator.registerLazySingleton<ApiService>(
    () => ApiService(
      locator(),
    ),
  );
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      locator(),
    ),
  );
  // Register Hive with GetIt

  locator.registerSingletonAsync<HiveInterface>(() async {
    await Hive.initFlutter();
    return Hive;
  });
}
