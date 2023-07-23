import 'package:mutiny/common/constants/env_keys.dart';

enum Flavor {
  DEV,
  STAGING,
  PROD,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get apiBaseUrl => const String.fromEnvironment(EnvKeys.baseURL);

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Mutiny DEV';
      case Flavor.STAGING:
        return 'Mutiny STAGING';
      case Flavor.PROD:
        return 'Mutiny';
      default:
        return 'Mutiny DEV';
    }
  }
}
