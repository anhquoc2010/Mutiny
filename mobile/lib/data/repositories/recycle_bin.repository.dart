import 'package:injectable/injectable.dart';
import 'package:mutiny/data/datasources/maps/recycle_bin.datasource.dart';

@lazySingleton
class RecycleBinRepository {
  RecycleBinRepository({required RecycleBinDataSource dataSource})
      : _dataSource = dataSource;
  final RecycleBinDataSource _dataSource;

  Future<void> getRecycleBins() {
    return _dataSource.getRecycleBins();
  }
}
