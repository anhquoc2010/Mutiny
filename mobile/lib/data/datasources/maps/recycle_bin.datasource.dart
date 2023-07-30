import 'package:injectable/injectable.dart';

@lazySingleton
class RecycleBinDataSource {
  RecycleBinDataSource();

  Future<void> getRecycleBins() async {
    // return [
    //   RecycleBinModel(
    //     // name: 'Recycle Bin',
    //     // type: 'Recycle Bin',
    //     // address: 'Recycle Bin',
    //     // description: 'Recycle Bin',
    //     // coordinate: {
    //     //   'lat': defaultLocation.latitude,
    //     //   'lng': defaultLocation.longitude,
    //     // },
    //   ),
    // ];
  }
}
