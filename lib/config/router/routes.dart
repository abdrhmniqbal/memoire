import 'package:auto_route/auto_route.dart';
import 'package:memoire/config/router/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: BookmarksRoute.page, initial: true),
    AutoRoute(page: SettingsRoute.page),
  ];
}

final appRouter = AppRouter();
