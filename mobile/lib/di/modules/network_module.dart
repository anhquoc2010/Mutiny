import 'package:injectable/injectable.dart';

import 'package:mutiny/common/helpers/dio_helper.dart';
import 'package:mutiny/di/providers/dio_provider.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  DioHelper provideDioHelper(DioProvider dioProvider) {
    return DioHelper(dio: dioProvider.getDio());
  }
}
