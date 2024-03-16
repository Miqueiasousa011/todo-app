import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/mixins/loading_overlay_mixin.dart';
import '../../../../../core/themes/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoadingOverlayStateMixin {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
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
                  onChanged: (email) {},
                  // validator: loginBloc.emailValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                InputComponent.password(
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  onChanged: (senha) {},
                  // validator: loginBloc.passwordValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                ElevatedButtonComponent(
                  title: 'Entrar',
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    if (formKey.currentState?.validate() == true) {}

                    Modular.to.navigate('/home');
                  },
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
}
