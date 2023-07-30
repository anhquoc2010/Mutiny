import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mutiny/common/constants/endpoints.dart';
import 'package:mutiny/common/helpers/dio_helper.dart';
import 'package:mutiny/data/models/address/coordinate.model.dart';
import 'package:mutiny/data/models/place.model.dart';

@lazySingleton
class PlaceDataSource {
  PlaceDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;
  final DioHelper _dioHelper;

  Future<LatLng> getGeometry(String placeId) async {
    final HttpRequestResponse response = await _dioHelper.get(
      '${Endpoints.geoCode}&place_id=$placeId',
    );

    Map<String, dynamic> geoLocation =
        response.data['results'][0]['geometry']['location'];

    return LatLng(
      geoLocation['lat'],
      geoLocation['lng'],
    );
  }

  Future<List<CoordinateModel>> getCoordinates() async {
    return [];
  }

  

  Future<List<PlaceModel>> getSuggestPlaces(String input) async {
    final String country = Platform.localeName.split('_')[0];
    final HttpRequestResponse response = await _dioHelper
        .get('${Endpoints.autocompletePlace}&input=$input&language=$country');

    final List<PlaceModel> places =
        (response.data['predictions'] as List<dynamic>)
            .map((e) => PlaceModel.fromJson(e))
            // .where(
            //   (element) => element.types
            //       .any((element2) => placeFilter.contains(element2)),
            // )
            .toList();

    //call api to get geometry

    final locations = await Future.wait(places.map((e) => getGeometry(e.placeId)));

    for (int i = 0; i < places.length; i++) {
      places[i] = places[i].copyWith(location: locations[i]);
    }

    return places;
  }
}
