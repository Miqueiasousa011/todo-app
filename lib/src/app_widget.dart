import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/themes/themes.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.routerDelegate.setObservers([routeObserver]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: appLightTheme(context),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
