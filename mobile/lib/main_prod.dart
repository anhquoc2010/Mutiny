import 'package:mutiny/app/app.dart';
import 'package:mutiny/bootstrap.dart';
import 'package:mutiny/flavors.dart';

Future<void> main() async {
  await bootstrap(
    () {
      return const App();
    },
    Flavor.PROD,
  );
}
