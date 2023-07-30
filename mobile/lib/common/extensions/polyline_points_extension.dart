import 'dart:developer';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

extension NetworkUtilExtension on NetworkUtil {
  Future<PolylineResult> getRoutesBetweenCoordinates(
    String googleApiKey,
    PointLatLng origin,
    PointLatLng destination,
    TravelMode travelMode,
    List<PolylineWayPoint> wayPoints,
    bool avoidHighways,
    bool avoidTolls,
    bool avoidFerries,
    bool optimizeWaypoints,
  ) async {
    String mode = travelMode.toString().replaceAll('TravelMode.', '');
    PolylineResult result = PolylineResult();
    var params = {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'mode': mode,
      'avoidHighways': '$avoidHighways',
      'avoidFerries': '$avoidFerries',
      'avoidTolls': '$avoidTolls',
      'alternatives': 'true',
      'key': googleApiKey
    };
    if (wayPoints.isNotEmpty) {
      List wayPointsArray = [];
      for (var point in wayPoints) {
        wayPointsArray.add(point.location);
      }
      String wayPointsString = wayPointsArray.join('|');
      if (optimizeWaypoints) {
        wayPointsString = 'optimize:true|$wayPointsString';
      }
      params.addAll({'waypoints': wayPointsString});
    }
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/directions/json', params);

    //String url = uri.toString();
    // print('GOOGLE MAPS URL: ' + url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      result.status = parsedJson['status'];
      if (parsedJson['status']?.toLowerCase() == NetworkUtil.STATUS_OK &&
          parsedJson['routes'] != null &&
          parsedJson['routes'].isNotEmpty) {
        result.points = [];
        for (var route in parsedJson['routes']) {
          log('route: $route');
          result.points.addAll(
            decodeEncodedPolyline(
              route['overview_polyline']['points'],
            ),
          );
        }
        log('result.points: ${result.points}');
      } else {
        result.errorMessage = parsedJson['error_message'];
      }
    }
    return result;
  }
}

extension PolylinePointsExtension on PolylinePoints {
  Future<PolylineResult> getRoutesBetweenCoordinates(
    String googleApiKey,
    PointLatLng origin,
    PointLatLng destination, {
    TravelMode travelMode = TravelMode.driving,
    List<PolylineWayPoint> wayPoints = const [],
    bool avoidHighways = false,
    bool avoidTolls = false,
    bool avoidFerries = true,
    bool optimizeWaypoints = false,
  }) async {
    return await util.getRouteBetweenCoordinates(
      googleApiKey,
      origin,
      destination,
      travelMode,
      wayPoints,
      avoidHighways,
      avoidTolls,
      avoidFerries,
      optimizeWaypoints,
    );
  }
}
