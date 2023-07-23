import 'package:injectable/injectable.dart';
import 'package:mutiny/data/datasources/maps/recycle_bin.datasource.dart';
import 'package:mutiny/data/models/address/recycle_bin.model.dart';

@lazySingleton
class RecycleBinRepository {
  RecycleBinRepository({required RecycleBinDataSource dataSource})
      : _dataSource = dataSource;
  final RecycleBinDataSource _dataSource;

  Future<List<RecycleBinModel>> getRecycleBins() {
    return _dataSource.getRecycleBins();
  }
}
