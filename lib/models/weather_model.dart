import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/models/hourly_weather_model.dart';

class WeatherModel {
  final CurrentWeatherModel currentWeather;
  final List<HourlyWeatherModel> hourlyWeather;
  WeatherModel({required this.currentWeather, required this.hourlyWeather});
}
