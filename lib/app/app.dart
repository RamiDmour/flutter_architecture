import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/navigation/app_router.dart';

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
