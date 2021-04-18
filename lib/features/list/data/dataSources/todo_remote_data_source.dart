import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<Todo> getTodo(int id);
}

@Singleton(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImpl extends TodoRemoteDataSource {
  final Dio dio;

  TodoRemoteDataSourceImpl({required this.dio});

  @override
  Future<Todo> getTodo(int id) async {
    return await _getTodoFromUrl('/1');
  }

  Future<Todo> _getTodoFromUrl(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      print(response);
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
