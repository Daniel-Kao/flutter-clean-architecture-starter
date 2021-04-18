import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TestW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                print('asd');
                dispatchTodo(context);
              },
              child: Text('TextButton'),
            ),
          ),
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is Loaded) {
                return Container(
                  child: Text(state.todo.title),
                );
              } else {
                return Container(
                  child: Text('loading'),
                );
              }
            },
          )
        ],
      ),
    );
  }

  void dispatchTodo(context) {
    print('131');
    BlocProvider.of<TodoBloc>(context).add(GetTodoEvent(numberString: '1'));
  }
}
