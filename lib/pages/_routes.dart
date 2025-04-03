import 'package:go_router/go_router.dart';
import 'package:mountain/pages/home.dart';
import 'package:mountain/pages/settings.dart';
import 'package:mountain/pages/splash.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ]),
  ],
);
