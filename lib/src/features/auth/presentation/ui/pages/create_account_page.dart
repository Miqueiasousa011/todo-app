import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/mixins/loading_overlay_mixin.dart';
import '../../../../../core/themes/themes.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> with LoadingOverlayStateMixin {
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
        appBar: AppBar(title: const Text('Criar Conta')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppSpacings.medium,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacings.xxLarge),
                InputComponent(
                  label: 'Nome',
                  hintText: 'Digite seu nome',
                  onChanged: (email) {},
                  // validator: loginBloc.emailValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
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
                InputComponent.password(
                  label: 'Confirmar senha',
                  hintText: 'Digite sua senha',
                  onChanged: (senha) {},
                  // validator: loginBloc.passwordValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                ElevatedButtonComponent(
                  title: 'Criar Conta',
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    if (formKey.currentState?.validate() == true) {}
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
