import 'package:mutiny/flavors.dart';

abstract class Endpoints {
  static String apiUrl = '${AppFlavor.apiBaseUrl}/api';

  static String login = '$apiUrl/auth/login';
  static String userInfo = '$apiUrl/auth/me';

  static String geoCode = 'https://maps.googleapis.com/maps/api/geocode/json?key=${AppFlavor.googleMapApiKey}';
}
