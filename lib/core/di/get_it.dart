import 'package:animoo/core/resources/conts_values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import '../database/api/dio_service.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() {
  
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey<NavigatorState>(),instanceName: ConstsValuesManager.homePageNavigationState);
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey<NavigatorState>(),instanceName: 'searchPageNavigationState');
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioService>(() => DioService(getIt<Dio>()));
}
