import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_app/src/features/home/presentation/controllers/todo_controller.dart';
import 'package:todo_app/src/features/home/presentation/repositories/todo_repository.dart';
import 'package:todo_app/src/features/home/presentation/ui/pages/home_page.dart';

import 'presentation/ui/pages/todo_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => ToDoRepository(i())),
        Bind.singleton((i) => ToDoController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/todo', child: (context, args) => const TodoPage()),
      ];
}
