import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:mutiny/app/app_bloc_observer.dart';
import 'package:mutiny/common/helpers/firebase_service.dart';
import 'package:mutiny/di/di.dart';
import 'package:mutiny/flavors.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder, Flavor flavor) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      AppFlavor.appFlavor = flavor;

      await initializeApp();

      runApp(
        await builder(),
      );
    },
    (error, stack) =>
        log(error.toString(), stackTrace: stack, name: 'runZonedGuarded'),
  );
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  await Hive.initFlutter();

  await configureDependencies();

  await FirebaseService.init();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }

  await initNotifications();

  handleError();

  Bloc.observer = AppBlocObserver();
}

void handleError() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}


Future<void> initNotifications() async {
  final firebaseMessaging = FirebaseMessaging.instance;

  await firebaseMessaging.requestPermission();
  final fcmToken = await firebaseMessaging.getToken();
  log('fcmToken: $fcmToken');
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('handleBackgroundMessage - Title: ${message.notification?.title}');
  log('handleBackgroundMessage - Body: ${message.notification?.body}');
  log('handleBackgroundMessage - Payload: ${message.data}');
}


