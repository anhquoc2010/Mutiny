import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mutiny/flavors.dart';
import 'package:mutiny/generated/firebase_options/firebase_options_dev.dart' as firebase_option_dev;
import 'package:mutiny/generated/firebase_options/firebase_options_staging.dart' as firebase_option_staging;
import 'package:mutiny/generated/firebase_options/firebase_options_prod.dart' as firebase_option_prod;

abstract class FirebaseService {
  static FirebaseAnalytics analytic = FirebaseAnalytics.instance;

  static FirebaseOptions _getFirebaseOptions() {
    switch (AppFlavor.appFlavor) {
      case Flavor.PROD:
        return firebase_option_prod.DefaultFirebaseOptions.currentPlatform;
      case Flavor.STAGING:
        return firebase_option_staging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.DEV:
      default:
        return firebase_option_dev.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: _getFirebaseOptions(),
    );

    await _initAnalytic();
  }

  static Future<void> _initAnalytic() async {
    await analytic.setAnalyticsCollectionEnabled(true);
  }
}
