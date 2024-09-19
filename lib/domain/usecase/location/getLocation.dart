import 'package:geolocator/geolocator.dart';
import 'package:hidaya/data/source/location/location_service.dart';
import 'package:hidaya/service_locator.dart';

class GetlocationUseCase {
  Future<Position> call() async {
    return await sl<LocationService>().getLocation();
  }
}
