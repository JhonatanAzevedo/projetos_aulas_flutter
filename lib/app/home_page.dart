import 'package:aplicando_flutter/app/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _success() {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (bool? value) {},
          ),
          title: Text(todo.title),
        );
      },
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        child: Text('tenta novamente'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Todo\'s'),
        ),
        body: AnimatedBuilder(
          animation: controller.state,
          builder: (context, child) {
            return stateManagement(controller.state.value);
          },
        ));
  }
}
