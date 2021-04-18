import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  DataConnectionChecker dataConnectionChecker() => DataConnectionChecker();

  @Named("BaseUrl")
  String get baseUrl => 'https://jsonplaceholder.typicode.com/todos/';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) =>
      Dio(BaseOptions(baseUrl: url, contentType: Headers.jsonContentType));
}
