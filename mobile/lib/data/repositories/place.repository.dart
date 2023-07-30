import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mutiny/data/datasources/maps/place.datasource.dart';
import 'package:mutiny/data/models/address/coordinate.model.dart';
import 'package:mutiny/data/models/place.model.dart';

@lazySingleton
class PlaceRepository {
  PlaceRepository({required PlaceDataSource placeDataSource})
      : _dataSource = placeDataSource;
  final PlaceDataSource _dataSource;
  Future<LatLng> getGeometry(String placeId) {
    return _dataSource.getGeometry(placeId);
  }

  Future<List<CoordinateModel>> getCoordinates() async {
    return await _dataSource.getCoordinates();
  }

  Future<List<PlaceModel>> getSuggestPlaces(String input) {
    return _dataSource.getSuggestPlaces(input);
  }
}
