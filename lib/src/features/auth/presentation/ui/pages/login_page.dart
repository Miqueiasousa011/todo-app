import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/core/mixins/app_validators.dart';
import 'package:todo_app/src/features/auth/controllers/auth_controller.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/mixins/app_helper.dart';
import '../../../../../core/mixins/loading_overlay_mixin.dart';
import '../../../../../core/themes/themes.dart';

typedef LoginFunction = void Function(
  String email,
  String password, {
  required void Function() onSuccess,
  required void Function(String failure) onFailure,
});

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with LoadingOverlayStateMixin, AppHelper, AppValidators {
  late GlobalKey<FormState> formKey;
  late AuthController authController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    authController = Modular.get<AuthController>();
  }

  void _onSubmitted() {
    if (formKey.currentState?.validate() == true) {
      showLoading();
      monadLogin(authController.login, emailTextController.text, passwordTextController.text);
    }
  }

  void monadLogin(
    LoginFunction login,
    String email,
    String password,
  ) =>
      email.isNotEmpty && password.isNotEmpty
          ? login(
              email,
              password,
              onSuccess: onSuccess,
              onFailure: onFailure,
            )
          : null;

  void onSuccess() {
    removeLoading();
    Modular.to.navigate('/home');
  }

  void onFailure(String msg) {
    removeLoading();
    showError(msg);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacings.medium),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "TODO",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacings.xxLarge),
                InputComponent(
                  label: 'Email',
                  hintText: 'Digite seu email',
                  controller: emailTextController,
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                InputComponent.password(
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  controller: passwordTextController,
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                ElevatedButtonComponent(
                  title: 'Entrar',
                  onPressed: _onSubmitted,
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  child: const Text('Criar Conta'),
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    Modular.to.pushNamed('/create-account');
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showError(String error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.backgroundError,
          content: Text(
            error,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.error,
            ),
          ),
        ),
      );
}
