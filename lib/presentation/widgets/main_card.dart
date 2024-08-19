import 'dart:ui';

import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final double temparature;
  final String weatherState;

  const MainCard({
    super.key,
    required this.temparature,
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "${(temparature - 273.16).toStringAsFixed(2)} °C",
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    weatherState == 'Clouds' || weatherState == 'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                    size: 64,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    weatherState,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
