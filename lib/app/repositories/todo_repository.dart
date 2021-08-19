import 'package:aplicando_flutter/models/todo_model.dart';
import 'package:dio/dio.dart';

class TodoRepository {
  late Dio dio;
  final url = 'https://jsonplaceholder.typicode.com/todos';

  TodoRepository([Dio? client]){
    if (client == null){
      this.dio = Dio();
    } else{
      this.dio = client;
    }
  }

  Future<List<TodoModel>> fetchTodos() async {
    final response = await dio.get(url);
    final list = response.data as List;

    List<TodoModel> todos = [];
    for (var json in list) {
      final todo = TodoModel.fromJson(json);
      todos.add(todo);
    }
    return todos;
  }
}
