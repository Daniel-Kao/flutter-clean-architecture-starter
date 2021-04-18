import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/get_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.getTodo, required this.inputConverter})
      : super(Empty());

  final GetTodo getTodo;
  final InputConverter inputConverter;

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is GetTodoEvent) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();
        final failureOrTodo = await getTodo(Params(id: integer));
        yield* _eitherLoadOrErrorState(failureOrTodo);
      });
    }
  }

  Stream<TodoState> _eitherLoadOrErrorState(
      Either<Failure, Todo> failureOrTodo) async* {
    yield failureOrTodo.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (todo) => Loaded(todo: todo));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
