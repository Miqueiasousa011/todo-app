import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/core/components/loading_widget.dart';
import 'package:todo_app/src/features/home/presentation/controllers/todo_controller.dart';

import 'package:todo_app/src/features/home/presentation/models/todo_model.dart';

import '../../../../../core/themes/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ToDoController _toDoController;

  @override
  void initState() {
    super.initState();
    _toDoController = Modular.get<ToDoController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/home/todo');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacings.medium, horizontal: 10),
        child: FutureBuilder<List<ToDoModel>>(
          future: _toDoController.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
            }

            final todos = snapshot.data ?? [];

            if (todos.isEmpty) {
              return Center(
                child: Text(
                  "Você não possui tarefas cadastradas",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }

            return Column(
              children: [
                ...todos.map(
                  (todo) => ToDoItem(
                    onChanged: (p0) {},
                    todo: todo,
                    onDelete: () {},
                    onUpdate: () {},
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class ToDoItem extends StatelessWidget {
  const ToDoItem({
    super.key,
    required this.todo,
    this.onChanged,
    required this.onDelete,
    required this.onUpdate,
  });

  final ToDoModel todo;
  final void Function(bool?)? onChanged;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      isThreeLine: false,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: Text(todo.title!),
      subtitle: Text(todo.description!),
      secondary: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: onDelete,
            child: const Text('Excluir'),
          ),
          PopupMenuItem(
            onTap: onUpdate,
            child: const Text('Editar'),
          ),
        ],
      ),
      value: todo.status,
      onChanged: onChanged,
    );
  }
}
