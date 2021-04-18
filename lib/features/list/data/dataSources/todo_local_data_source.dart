import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<TodoModel> getTodo();
  Future<void> cacheTodo(Todo todoToCache);
}

const CACHED_TODO = 'CACHED_TODO';

@Singleton(as: TodoLocalDataSource)
class TodoLocalDataSourceImpl extends TodoLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<TodoModel> getTodo() {
    final jsonString = sharedPreferences.getString(CACHED_TODO);
    if (jsonString != null) {
      return Future.value(TodoModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTodo(Todo todoToCahce) {
    return sharedPreferences.setString(
        CACHED_TODO, jsonEncode(todoToCahce.toString()));
  }
}
