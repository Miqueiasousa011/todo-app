import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/features/auth/presentation/ui/pages/login_page.dart';

import 'presentation/ui/pages/create_account_page.dart';

class AuthModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
        ChildRoute('/create-account', child: (context, args) => const CreateAccountPage()),
      ];
}
