import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/components/components.dart';
import '../../../../../core/themes/themes.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  label: 'Título',
                  hintText: 'Digite o título da tarefa',
                  onChanged: (v) {},
                  // validator: loginBloc.emailValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                InputComponent(
                  label: 'Detalhes',
                  hintText: 'Digite os detalhes',
                  onChanged: (v) {},
                  // validator: loginBloc.emailValidator,
                ),
                const SizedBox(height: AppSpacings.medium),
                ElevatedButtonComponent(
                  title: 'Salvar',
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
