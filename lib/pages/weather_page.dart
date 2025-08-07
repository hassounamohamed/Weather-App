import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {


  // api key for OpenWeatherMap
  final _WeatherService = WeatherService('98a84505ac433b7d2e663c54b78f1f23');
  Weather? _weather;

  //fetch weather data for a specific city
  _fetchWeather() async {
    //get the current city name
    String cityName = await _WeatherService.getCurrentCity();
    //get weather for city
    try{
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        
      });
    }
    //any error
    catch(e){
      print (e)
;    }
  }
@override
void initState() {
  super.initState();
  //fetch weather data when the page is initialized
  _fetchWeather();
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'Loading city...'),
            Text('${_weather?.temperature.round()} °C'),
          ],
        ),
      ),
    );
  }
}