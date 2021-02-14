import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = _position.latitude;
      longitude = _position.longitude;

      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }
}
