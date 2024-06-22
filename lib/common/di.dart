import 'package:assets_manager/data/remote/my_rds.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDI() {
  initResources();
  initDataSources();
  initRepositories();
}

void initRepositories() {
  getIt.registerSingleton<MyRepository>(
    MyRepository(
      myRDS: getIt.get<MyRDS>(),
    ),
  );
}

void initDataSources() {
  const url = String.fromEnvironment('URL_PATH');
  getIt.registerSingleton<MyRDS>(
    MyRDS(
      url: url,
      dio: getIt.get<Dio>(),
    ),
  );
}

void initResources() {
  getIt.registerSingleton<Dio>(
    Dio(),
  );
}