import 'package:injectable/injectable.dart';
import 'package:mutiny/data/datasources/maps/place.datasource.dart';
import 'package:mutiny/data/models/address/coordinate.model.dart';

@lazySingleton
class PlaceRepository {
  PlaceRepository({required PlaceDataSource placeDataSource})
      : _dataSource = placeDataSource;
  final PlaceDataSource _dataSource;
  Future<Map<String, double>> getGeometry(String placeId) {
    return _dataSource.getGeometry(placeId);
  }

  Future<List<CoordinateModel>> getCoordinates() async {
    return await _dataSource.getCoordinates();
  }
}
