import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/features/home/presentation/controllers/todo_controller.dart';
import 'package:todo_app/src/features/home/presentation/models/todo_model.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/mixins/app_helper.dart';
import '../../../../../core/mixins/app_validators.dart';
import '../../../../../core/mixins/loading_overlay_mixin.dart';
import '../../../../../core/themes/themes.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, this.toDoModel});

  final ToDoModel? toDoModel;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with LoadingOverlayStateMixin, AppHelper, AppValidators {
  final formKey = GlobalKey<FormState>();
  late ToDoController _todoController;
  late ToDoModel toDoModel;
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    _todoController = Modular.get<ToDoController>();

    toDoModel = widget.toDoModel ?? ToDoModel();
  }

  initValues() {
    if (widget.toDoModel != null) {
      titleTextController.text = widget.toDoModel!.title!;
      descriptionTextController.text = widget.toDoModel!.description!;
    }
  }

  void _onSubmitted() {
    if (formKey.currentState?.validate() == true) {
      showLoading();
      _todoController.createAccount(
        toDoModel,
        onSuccess: (e) {
          removeLoading();
          showSuccess(e);
          Modular.to.pop();
        },
        onFailure: (e) {
          removeLoading();
          showError(e);
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initValues();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('TODO')),
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
                  controller: titleTextController,
                  label: 'Título',
                  hintText: 'Digite o título da tarefa',
                  onChanged: (v) {
                    toDoModel.title = v;
                  },
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                InputComponent(
                  controller: descriptionTextController,
                  label: 'Detalhes',
                  hintText: 'Digite os detalhes',
                  onChanged: (v) {
                    toDoModel.description = v;
                  },
                  validator: requiredValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                ElevatedButtonComponent(
                  title: 'Salvar',
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    _onSubmitted();
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
}
