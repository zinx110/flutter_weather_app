import "dart:convert";

import "package:flutter_weather_app/secrets.dart";
import "package:http/http.dart" as http;

import "package:flutter/material.dart";
import "package:flutter_weather_app/components/additional_info_card.dart";
import "package:flutter_weather_app/components/main_card.dart";

import "package:flutter_weather_app/components/weather_forecast_card.dart";
import "package:intl/intl.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    String cityName = "London";
    String countryName = "uk";
    String apiDomain = "https://api.openweathermap.org";
    Uri url = Uri.parse(
        '$apiDomain/data/2.5/forecast?q=$cityName,$countryName&APPID=$OPEN_WEATHER_API_KEY');
    try {
      final res = await http.get(url);
      final data = jsonDecode(res.body);
      if (res.statusCode != 200 || data['cod'] != '200') {
        throw 'An unextended error occurred';
      }

      // double temp = data['list'][0]['main']['temp'];
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  weather = getCurrentWeather();
                });
              },
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final double currentTemperature = currentWeatherData['main']['temp'];
          final String currentWeatherState =
              currentWeatherData['weather'][0]['main'];
          final String currentPressure =
              currentWeatherData['main']['pressure'].toString();
          final String currentHumidity =
              currentWeatherData['wind']['speed'].toString();
          final String currentWindSpeed =
              currentWeatherData['main']['humidity'].toString();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                MainCard(
                  temparature: currentTemperature,
                  weatherState: currentWeatherState,
                ),

                const SizedBox(height: 20),
                // weather forecast cards
                const Text(
                  "Weather Forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 30; i++)
                //         WeatherForecastCard(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           weatherState: data['list'][i + 1]['weather'][0]
                //                   ['main']
                //               .toString(),
                //           temperature:
                //               (data['list'][i + 1]['main']['temp'] - 273.16),
                //         ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourlyForecastData = data['list'][index + 1];
                      final time = DateTime.parse(hourlyForecastData['dt_txt']);
                      return WeatherForecastCard(
                          time: DateFormat.Hm().format(time),
                          temperature: hourlyForecastData['main']['temp'],
                          weatherState: hourlyForecastData['weather'][0]
                              ['main']);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // weather forecast cards
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // additional information cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const AdditionalInfoCard(
                      name: "Humidity",
                      icon: Icons.water_drop,
                      value: "90",
                    ),
                    AdditionalInfoCard(
                      name: currentHumidity,
                      icon: Icons.air,
                      value: currentWindSpeed,
                    ),
                    AdditionalInfoCard(
                      name: "Pressure",
                      icon: Icons.thermostat,
                      value: currentPressure,
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
