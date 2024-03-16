import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/core/utils/dio.dart';
import 'package:todo_app/src/features/home/home_module.dart';

import 'features/auth/auth_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => customDio),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
