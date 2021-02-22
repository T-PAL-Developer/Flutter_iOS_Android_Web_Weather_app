import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const String apiKey = '2f601ff27d95ea7a9d5f5a7b0db8822c';
const String apiURL = 'https://api.openweathermap.org/data/2.5/weather';
const String apiLanguage = 'en';
const String units = 'metric';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$apiURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getGPSLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String url =
        '$apiURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&lang=$apiLanguage&units=$units';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temperature) {
    if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for shorts and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
