import 'package:hidaya/data/source/location/location_service.dart';
import 'package:hidaya/domain/respository/location/location_repositorty.dart';
import 'package:hidaya/service_locator.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl extends LocationRepositorty {
  @override
  Future<Position> getLocation() async {
    return await sl<LocationService>().getLocation();
  }
}
