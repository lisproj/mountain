import 'package:go_router/go_router.dart';
import 'package:mountain/pages/splash.dart';
import 'package:mountain/components/layout/navbar.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/tabs',
      builder: (context, state) => const NavigationSidebar(),
    ),
  ],
);
