import 'package:todo_app/src/features/home/presentation/models/todo_model.dart';
import 'package:todo_app/src/features/home/presentation/repositories/todo_repository.dart';

import '../../../../core/utils/app_exception.dart';

class ToDoController {
  final ToDoRepository _toDoRepository;

  ToDoController(this._toDoRepository);

  Future<void> createAccount(
    ToDoModel todo, {
    required void Function() onSuccess,
    required void Function(String failure) onFailure,
  }) async {
    try {
      await _toDoRepository.create(
        {
          "title": todo.title,
          "description": todo.description,
        },
      );

      return onSuccess();
    } on AppException catch (e) {
      return onFailure(e.msg);
    }
  }

  Future<void> update(
    ToDoModel todo, {
    required void Function() onSuccess,
    required void Function(String failure) onFailure,
  }) async {
    try {
      await _toDoRepository.update(todo);
      return onSuccess();
    } on AppException catch (e) {
      return onFailure(e.msg);
    }
  }

  Future<void> delete(
    ToDoModel todo, {
    required void Function() onSuccess,
    required void Function(String failure) onFailure,
  }) async {
    try {
      await _toDoRepository.delete(todo.id!);
      return onSuccess();
    } on AppException catch (e) {
      return onFailure(e.msg);
    }
  }

  Future<List<ToDoModel>> getAll() async {
    try {
      return await _toDoRepository.getAll();
    } catch (e) {
      return [];
    }
  }
}
