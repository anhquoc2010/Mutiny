import 'package:flutter/material.dart';
import 'package:mutiny/presentation/auth/views/login_view.dart';
import 'package:mutiny/presentation/core/views/root_view.dart';
import 'package:mutiny/presentation/maps/view/location_search.view.dart';
import 'package:mutiny/presentation/maps/view/maps.view.dart';
import 'package:mutiny/presentation/splash/splash.dart';

abstract class AppRouter {
  static const String splash = '/';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  static const String locationSearch = '/locationSearch';
  // Root
  static const String root = '/root';

  // Maps
  static const String maps = '/maps';

  // static final router = GoRouter(
  //   routes: [
  //     GoRoute(
  //       path: login,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: LoginPage(),
  //         );
  //       },
  //     ),
  //     GoRoute(
  //       path: register,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: RegisterView(),
  //         );
  //       },
  //     ),
  //     GoRoute(
  //       path: root,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: RootPage(),
  //         );
  //       },
  //     )
  //   ],
  //   initialLocation: login,
  // );

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashPage();
          },
        );
      case login:
        return MaterialPageRoute(
          builder: (_) {
            return const LoginPage();
          },
        );
      case root:
        return MaterialPageRoute(
          builder: (_) {
            return const RootPage();
          },
        );
      case maps:
        return MaterialPageRoute(
          builder: (_) {
            return const MapsPage();
          },
        );
      case locationSearch:
        return MaterialPageRoute(
          builder: (_) {
            return const LocationSearchPage();
          },
        );
      default:
        return null;
    }
  }
}
