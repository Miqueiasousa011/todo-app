import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/features/home/presentation/ui/pages/home_page.dart';

import 'presentation/ui/pages/todo_page.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/todo', child: (context, args) => const TodoPage()),
      ];
}
