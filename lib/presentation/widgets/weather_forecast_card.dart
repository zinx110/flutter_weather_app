import 'package:flutter/material.dart';

class WeatherForecastCard extends StatelessWidget {
  final String time;
  final double temperature;
  final String weatherState;
  const WeatherForecastCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Icon(
              weatherState == "Clouds" || weatherState == "Rain"
                  ? Icons.cloud
                  : Icons.sunny,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              "${temperature.toStringAsFixed(2)} °C",
              style: const TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
