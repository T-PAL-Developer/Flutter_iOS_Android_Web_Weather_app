import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFiledInputDecoration,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black54,
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
