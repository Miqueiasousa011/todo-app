import 'package:dio/dio.dart';

import '../../../../core/utils/app_exception.dart';
import '../models/todo_model.dart';

class ToDoRepository {
  final Dio _dio;

  ToDoRepository(this._dio);

  Future<List<ToDoModel>> getAll() async {
    try {
      final response = await _dio.get('/todo');

      return response.data
          .map<ToDoModel>(
            (json) => ToDoModel(
              id: json['id'],
              title: json['title'],
              description: json['description'],
              status: json['isComplete'],
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw AppException(e.response?.data['message']);
    }
  }

  Future<void> create(Map<String, dynamic> data) async {
    try {
      await _dio.post('/todo', data: data);
    } on DioException catch (e) {
      throw AppException(e.response?.data['message']);
    }
  }

  Future<void> update(ToDoModel todo) async {
    try {
      await _dio.put(
        '/todo/${todo.id}',
        data: {
          "title": todo.title,
          "description": todo.description,
          "isComplete": todo.status,
        },
      );
    } on DioException catch (e) {
      throw AppException(e.response?.data['message']);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _dio.delete('/todo/$id');
    } on DioException catch (e) {
      throw AppException(e.response?.data['message']);
    }
  }
}
