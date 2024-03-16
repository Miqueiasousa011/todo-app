import 'package:todo_app/src/features/auth/repository/auth_repository.dart';

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
    } catch (e) {
      return onFailure('Algo deu errado! Verifique suas credenciais');
    }
  }
}
