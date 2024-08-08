import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_weather_app/bloc/weather_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_weather_app/presentation/widgets/additional_info_card.dart";
import "package:flutter_weather_app/presentation/widgets/main_card.dart";

import "package:flutter_weather_app/presentation/widgets/weather_forecast_card.dart";
import "package:intl/intl.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
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
                  context.read<WeatherBloc>().add(WeatherFetched());
                });
              },
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          // if (state.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator.adaptive(),
          //   );
          // }
          // if (snapshot.hasError) {
          //   return Center(child: Text(snapshot.error.toString()));
          // }
          if (state is WeatherFailure) {
            return Center(child: Text(state.error));
          }
          if (state is! WeatherSuccess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = state.weatherModel.currentWeather;

          final double currentTemperature = data.currentTemp;
          final String currentWeatherState = data.currentSky;
          final double currentPressure = data.currentPressure;
          final double currentHumidity = data.currentHumidity;
          final double currentWindSpeed = data.currentWindSpeed;

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
                      final hourlyForecastData =
                          state.weatherModel.hourlyWeather[index + 1];

                      final time =
                          DateTime.parse(hourlyForecastData.hourlyTime);
                      final hourlyTemp = hourlyForecastData.hourlyTemperature;
                      final hourlySky = hourlyForecastData.hourlySky;

                      return WeatherForecastCard(
                          time: DateFormat.Hm().format(time),
                          temperature: hourlyTemp,
                          weatherState: hourlySky);
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
                    AdditionalInfoCard(
                      name: "Humidity",
                      icon: Icons.water_drop,
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoCard(
                      name: "Wind Speed",
                      icon: Icons.air,
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoCard(
                      name: "Pressure",
                      icon: Icons.thermostat,
                      value: currentPressure.toString(),
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
