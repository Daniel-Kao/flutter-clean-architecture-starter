import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> getTodo(int id);
}
