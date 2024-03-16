import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/features/auth/presentation/ui/pages/login_page.dart';

import 'controllers/auth_controller.dart';
import 'presentation/ui/pages/create_account_page.dart';
import 'repository/auth_repository.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => AuthRepository(i())),
        Bind.singleton((i) => AuthController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
        ChildRoute('/create-account', child: (context, args) => const CreateAccountPage()),
      ];
}
