import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../dataSources/todo_local_data_source.dart';
import '../dataSources/todo_remote_data_source.dart';

typedef Future<Todo> _TodoGetter();

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Todo>> getTodo(int id) async {
    return await _getTodo(() {
      return remoteDataSource.getTodo(id);
    });
  }

  Future<Either<Failure, Todo>> _getTodo(
    _TodoGetter todoGetter,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTodo = await todoGetter();
        localDataSource.cacheTodo(remoteTodo);
        return Right(remoteTodo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTodo = await localDataSource.getTodo();
        return Right(localTodo);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
