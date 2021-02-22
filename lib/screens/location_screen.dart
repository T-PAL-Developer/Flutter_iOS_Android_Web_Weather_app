import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather_model.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherDataGPS});
  final weatherDataGPS;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String weatherIcon;
  String weatherComment;
  double temperature;
  String city;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        city = '';
        weatherIcon = '🤭';
        weatherComment = 'Unable to get weather, check GPS permission';
        return;
      }
      temperature = weatherData['main']['temp'];
      city = weatherData['name'];
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherComment = '${weather.getMessage(temperature)} in $city';
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherDataGPS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        weatherComment = 'Checking GPS location';
                      });
                      var weatherData = await weather.getGPSLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherComment',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
