import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/test_w.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('go'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<TodoBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TodoBloc>(),
      child: TestW(),
    );
  }
}
