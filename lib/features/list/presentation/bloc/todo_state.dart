import '../../domain/entities/todo.dart';

abstract class TodoState {
  const TodoState();
}

class Empty implements TodoState {}

class Loading implements TodoState {}

class Loaded implements TodoState {
  final Todo todo;

  Loaded({required this.todo});
}

class Error extends TodoState {
  final String message;

  Error({required this.message});
}
