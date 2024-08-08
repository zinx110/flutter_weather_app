// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HourlyWeatherModel {
  final String hourlyTime;
  final double hourlyTemperature;
  final String hourlySky;
  HourlyWeatherModel({
    required this.hourlyTime,
    required this.hourlyTemperature,
    required this.hourlySky,
  });

  HourlyWeatherModel copyWith({
    String? hourlyTime,
    double? hourlyTemperature,
    String? hourlySky,
  }) {
    return HourlyWeatherModel(
      hourlyTime: hourlyTime ?? this.hourlyTime,
      hourlyTemperature: hourlyTemperature ?? this.hourlyTemperature,
      hourlySky: hourlySky ?? this.hourlySky,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hourlyTime': hourlyTime,
      'hourlyTemperature': hourlyTemperature,
      'hourlySky': hourlySky,
    };
  }

  factory HourlyWeatherModel.fromMap(Map<String, dynamic> map) {
    final hourlyForecastData = map;

    return HourlyWeatherModel(
        hourlyTime: DateTime.parse(hourlyForecastData['dt_txt']).toString(),
        hourlyTemperature: hourlyForecastData['main']['temp'].toDouble(),
        hourlySky: hourlyForecastData['weather'][0]['main'] as String);
  }

  String toJson() => json.encode(toMap());

  factory HourlyWeatherModel.fromJson(String source) =>
      HourlyWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HourlyWeatherModel(hourlyTime: $hourlyTime, hourlyTemperature: $hourlyTemperature, hourlySky: $hourlySky)';

  @override
  bool operator ==(covariant HourlyWeatherModel other) {
    if (identical(this, other)) return true;

    return other.hourlyTime == hourlyTime &&
        other.hourlyTemperature == hourlyTemperature &&
        other.hourlySky == hourlySky;
  }

  @override
  int get hashCode =>
      hourlyTime.hashCode ^ hourlyTemperature.hashCode ^ hourlySky.hashCode;
}
