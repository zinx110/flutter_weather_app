part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherModel;

  WeatherSuccess(this.weatherModel);
}

final class WeatherFailure extends WeatherState {
  final String error;
  WeatherFailure(this.error) {
    print("error : $error");
  }
}

final class WeatherLoading extends WeatherState {}
