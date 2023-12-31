import 'package:auto_route/auto_route.dart';
import 'package:flutter_architecture/presentation/todo/page/todo_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TodoRoute.page, initial: true),
      ];
}
