import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/src/core/utils/dio.dart';
import 'package:todo_app/src/features/home/home_module.dart';

import 'features/auth/auth_module.dart';

class AppModule extends Module {
  final SharedPreferences _storage;

  AppModule(this._storage);

  @override
  List<Bind<Object>> get binds => [
        Bind.instance<SharedPreferences>(_storage),
        Bind.singleton((i) => customDio),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
