import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class GetTodoEvent implements TodoEvent {
  final String numberString;

  const GetTodoEvent({required this.numberString});

  @override
  List<Object> get props => [numberString];

  @override
  bool get stringify => true;
}
