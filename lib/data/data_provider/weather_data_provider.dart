import 'package:flutter_weather_app/secrets.dart';
import "package:http/http.dart" as http;

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName, String countryName) async {
    String apiDomain = "https://api.openweathermap.org";
    Uri url = Uri.parse(
        '$apiDomain/data/2.5/forecast?q=$cityName,$countryName&APPID=$OPEN_WEATHER_API_KEY');
    try {
      final res = await http.get(url);

      // double temp = data['list'][0]['main']['temp'];
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
