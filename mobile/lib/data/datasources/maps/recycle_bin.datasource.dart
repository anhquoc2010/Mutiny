import 'package:injectable/injectable.dart';
import 'package:mutiny/common/constants/constants.dart';
import 'package:mutiny/data/models/address/recycle_bin.model.dart';

@lazySingleton
class RecycleBinDataSource {
  RecycleBinDataSource();

  Future<List<RecycleBinModel>> getRecycleBins() async {
    return [
      RecycleBinModel(
        name: 'Recycle Bin',
        type: 'Recycle Bin',
        address: 'Recycle Bin',
        description: 'Recycle Bin',
        coordinate: {
          'lat': defaultLocation.latitude,
          'lng': defaultLocation.longitude,
        },
      ),
    ];
  }
}
