import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/src/app_module.dart';
import 'package:todo_app/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await SharedPreferences.getInstance();

  runApp(
    ModularApp(
      module: AppModule(storage),
      child: const AppWidget(),
    ),
  );
}
