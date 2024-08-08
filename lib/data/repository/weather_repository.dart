import 'dart:convert';

import 'package:flutter_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/models/hourly_weather_model.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    String cityName = "London";
    String countryName = "uk";
    try {
      final weatherData =
          await weatherDataProvider.getCurrentWeather(cityName, countryName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw "An Unexpected error occurred";
      }

      final currentWeather = CurrentWeatherModel.fromMap(data);

      final hourlyWeatherListRaw = data['list'];

      final List<HourlyWeatherModel> hourlyList = [];

      for (Map<String, dynamic> hourlyRaw in hourlyWeatherListRaw) {
        hourlyList.add(HourlyWeatherModel.fromMap(hourlyRaw));
      }

      return WeatherModel(
          currentWeather: currentWeather, hourlyWeather: hourlyList);
    } catch (e) {
      throw e.toString();
    }
  }
}
