import 'package:aplicando_flutter/app/repositories/todo_repository.dart';
import 'package:aplicando_flutter/models/todo_model.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  late List<TodoModel> todos = [];
  final TodoRepository _repository;
  final state = ValueNotifier<HomeState>(HomeState.start);

  HomeController([TodoRepository? repository])
      : _repository = repository ?? TodoRepository();

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await _repository.fetchTodos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

// mapeando estado pra ver os estados que tem ser feito.
enum HomeState { start, loading, success, error }
