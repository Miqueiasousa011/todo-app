import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/features/auth/models/account_form_model.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/mixins/app_helper.dart';
import '../../../../../core/mixins/app_validators.dart';
import '../../../../../core/mixins/loading_overlay_mixin.dart';
import '../../../../../core/themes/themes.dart';
import '../../../controllers/auth_controller.dart';

typedef CreateAccountFunction = void Function(
  AccountFormModel mdel, {
  required void Function() onSuccess,
  required void Function(String failure) onFailure,
});

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>
    with LoadingOverlayStateMixin, AppHelper, AppValidators {
  late GlobalKey<FormState> formKey;

  late AuthController authController;
  late AccountFormModel formModel;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    authController = Modular.get<AuthController>();
    formModel = AccountFormModel();
  }

  void _onSubmitted() {
    if (formKey.currentState?.validate() == true) {
      showLoading();
      monadLogin(authController.createAccount, formModel);
    }
  }

  void monadLogin(
    CreateAccountFunction createAccount,
    AccountFormModel model,
  ) =>
      model.isValid
          ? createAccount(
              model,
              onSuccess: onSuccess,
              onFailure: onFailure,
            )
          : null;

  void onSuccess() {
    removeLoading();
    showSuccess("Conta criada com sucesso!");
    Modular.to.navigate('/');
  }

  void onFailure(String msg) {
    removeLoading();
    showError(msg);
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
                  onChanged: (name) {
                    formModel.name = name;
                  },
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                InputComponent(
                  label: 'Email',
                  hintText: 'Digite seu email',
                  onChanged: (email) {
                    formModel.email = email;
                  },
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                InputComponent.password(
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  onChanged: (pass) {
                    formModel.password = pass;
                  },
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                ElevatedButtonComponent(
                  title: 'Criar Conta',
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    if (formKey.currentState?.validate() == true) {
                      _onSubmitted();
                    }
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

  void showSuccess(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.green,
          content: Text(
            msg,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.error,
            ),
          ),
        ),
      );
}
