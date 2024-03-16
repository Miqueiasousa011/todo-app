import 'package:dio/dio.dart';

import '../models/account_model.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AccountModel> login(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/auth/signin', data: data);
      return AccountModel(token: response.data['token']);
    } catch (e) {
      throw Exception("AuthRepository Exception");
    }
  }
}
