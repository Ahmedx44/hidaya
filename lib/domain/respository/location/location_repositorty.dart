import 'package:geolocator/geolocator.dart';

abstract class LocationRepositorty {
  Future<Position> getLocation();
}
