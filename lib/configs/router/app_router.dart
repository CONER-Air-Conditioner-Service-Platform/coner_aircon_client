import 'package:coner_client/configs/router/page_transition.dart';
import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/screens/bottom_bar/bottom_bar.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      /* public */
      GoRoute(
        name: RouteNames.main,
        path: '/',
        pageBuilder: (context, state) => PageTrainsition.fadeTransition(state, const BottomBar()),
      ),
    ],
    debugLogDiagnostics: true, // route debug log 출력
  );
}
