import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  }) : super(
          userId: userId,
          id: id,
          title: title,
          completed: completed,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed']);
  }

  @override
  List<Object> get props => [userId, id, title, completed];
}
