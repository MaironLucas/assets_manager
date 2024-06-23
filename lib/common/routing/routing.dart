import 'package:assets_manager/common/routing/route_paths.dart';
import 'package:assets_manager/presentation/home/home_page.dart';
import 'package:go_router/go_router.dart';

final appRoutes = GoRouter(
  initialLocation: RoutePaths.homePath,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RoutePaths.homePath,
      builder: (context, state) {
        return HomePage();
      },
    ),
  ],
);
