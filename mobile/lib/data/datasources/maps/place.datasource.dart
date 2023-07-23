import 'package:injectable/injectable.dart';
import 'package:mutiny/common/constants/endpoints.dart';
import 'package:mutiny/common/helpers/dio_helper.dart';
import 'package:mutiny/data/models/address/coordinate.model.dart';

@lazySingleton
class PlaceDataSource {
  PlaceDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;
  final DioHelper _dioHelper;

  Future<Map<String, double>> getGeometry(String placeId) async {
    final HttpRequestResponse response = await _dioHelper.get(
      '${Endpoints.geoCode}&place_id=$placeId',
    );

    Map<String, dynamic> geoLocation =
        response.data['results'][0]['geometry']['location'];

    return {
      'lat': double.parse(
        (geoLocation['lat'] as double).toStringAsFixed(4),
      ),
      'lng': double.parse(
        (geoLocation['lng'] as double).toStringAsFixed(4),
      ),
    };
  }

  Future<List<CoordinateModel>> getCoordinates() async {
    return [];
  }
}
