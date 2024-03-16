import 'package:todo_app/src/features/auth/repository/auth_repository.dart';

import '../../../core/utils/app_exception.dart';
import '../models/account_form_model.dart';

class AuthController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  Future<void> login(
    String email,
    String password, {
    required void Function() onSuccess,
    required void Function(String failure) onFailure,
  }) async {
    try {
      await _authRepository.login({"email": email, "password": password});
      return onSuccess();
    } on AppException catch (e) {
      return onFailure(e.msg);
    }
  }

  Future<void> createAccount(
    AccountFormModel model, {
    required void Function() onSuccess,
    required void Function(String failure) onFailure,
  }) async {
    try {
      await _authRepository.create({
        "name": model.name,
        "email": model.email,
        "password": model.password,
      });

      return onSuccess();
    } on AppException catch (e) {
      return onFailure(e.msg);
    }
  }
}
