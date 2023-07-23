import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutiny/common/constants/locales.dart';
import 'package:mutiny/common/theme/app_theme.dart';
import 'package:mutiny/generated/codegen_loader.g.dart';
import 'package:mutiny/router/app_router.dart';
import 'package:mutiny/data/repositories/user_repository.dart';
import 'package:mutiny/di/di.dart';
import 'package:mutiny/flavors.dart';
import 'package:mutiny/presentation/auth/bloc/auth/auth_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        AppLocales.en,
        AppLocales.vi,
      ],
      path: AppLocales.path,
      fallbackLocale: AppLocales.en,
      startLocale: AppLocales.en,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Builder(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthBloc(
                userRepository: getIt.get<UserRepository>(),
              ),
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                title: AppFlavor.title,
                theme: AppTheme.themeData,
                onGenerateRoute: AppRouter.onGenerateRoute,
                initialRoute: AppRouter.splash,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                builder: (_, child) {
                  return BlocListener<AuthBloc, AuthState>(
                    listener: (_, state) {
                      switch (state.status) {
                        case AuthenticationStatus.unknown:
                          break;
                        case AuthenticationStatus.authenticated:
                          _navigator.pushNamedAndRemoveUntil(
                            AppRouter.root,
                            (route) => false,
                          );
                          break;
                        case AuthenticationStatus.unauthenticated:
                          _navigator.pushNamedAndRemoveUntil(
                            AppRouter.root,
                            (route) => false,
                          );
                          break;
                      }
                    },
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
