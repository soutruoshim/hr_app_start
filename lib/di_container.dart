import 'package:hr_app/data/repository/parse_repo.dart';
import 'package:hr_app/data/repository/product_repo.dart';
import 'package:hr_app/provider/parse_provider.dart';
import 'package:hr_app/provider/product_provider.dart';
import 'package:hr_app/provider/report_parse_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/splash_repo.dart';
import 'provider/auth_provider.dart';
import 'provider/splash_provider.dart';
import 'provider/theme_provider.dart';
import 'utill/app_constants.dart';

final sl = GetIt.instance;
Future<void> init() async {

  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(),
          sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ParseRepo());
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(sharedPreferences: sl(), dioClient: sl()));


  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ParseProvider(parseRepo: sl()));
  sl.registerFactory(() => ReportParseProvider(parseRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}