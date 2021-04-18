// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data_connection_checker/data_connection_checker.dart' as _i5;
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import 'core/di/modules/register_module.dart' as _i14;
import 'core/network/network_info.dart' as _i4;
import 'core/util/input_converter.dart' as _i3;
import 'features/list/data/dataSources/todo_local_data_source.dart' as _i10;
import 'features/list/data/dataSources/todo_remote_data_source.dart' as _i9;
import 'features/list/data/repositories/todo_repository_impl.dart' as _i8;
import 'features/list/domain/repositories/todo_repository.dart' as _i7;
import 'features/list/domain/usecases/get_todo.dart' as _i11;
import 'features/list/presentation/bloc/todo_bloc.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.InputConverter>(() => _i3.InputConverter());
  gh.factory<_i4.NetworkInfo>(
      () => _i4.NetworkInfoImpl(get<_i5.DataConnectionChecker>()));
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'BaseUrl');
  gh.lazySingleton<_i6.Dio>(
      () => registerModule.dio(get<String>(instanceName: 'BaseUrl')));
  gh.factory<_i7.TodoRepository>(() => _i8.TodoRepositoryImpl(
      networkInfo: get<_i4.NetworkInfo>(),
      remoteDataSource: get<_i9.TodoRemoteDataSource>(),
      localDataSource: get<_i10.TodoLocalDataSource>()));
  gh.factory<_i11.GetTodo>(() => _i11.GetTodo(get<_i7.TodoRepository>()));
  gh.factory<_i12.TodoBloc>(() => _i12.TodoBloc(
      getTodo: get<_i11.GetTodo>(), inputConverter: get<_i3.InputConverter>()));
  gh.singleton<_i5.DataConnectionChecker>(
      registerModule.dataConnectionChecker());
  await gh.singletonAsync<_i13.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.singleton<_i10.TodoLocalDataSource>(_i10.TodoLocalDataSourceImpl(
      sharedPreferences: get<_i13.SharedPreferences>()));
  gh.singleton<_i9.TodoRemoteDataSource>(
      _i9.TodoRemoteDataSourceImpl(dio: get<_i6.Dio>()));
  return get;
}

class _$RegisterModule extends _i14.RegisterModule {}
