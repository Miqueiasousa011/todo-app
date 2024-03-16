import 'package:dio/dio.dart';

import '../../../core/utils/app_exception.dart';
import '../models/account_model.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AccountModel> login(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/auth/signin', data: data);
      return AccountModel(token: response.data['token']);
    } on DioException catch (e) {
      throw AppException(e.response?.data['message']);
    }
  }

  Future<void> create(Map<String, dynamic> data) async {
    try {
      await _dio.post('/auth/signup', data: data);
    } on DioException catch (e) {
      throw AppException(e.response?.data['message']);
    }
  }
}
