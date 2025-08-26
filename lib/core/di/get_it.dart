import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../database/api/dio_service.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioService>(() => DioService(getIt<Dio>()));
}
