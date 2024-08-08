// lib/presentation/blocs/weather_event.dart
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String cityName;

  const FetchWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class ToggleTemperatureUnit extends WeatherEvent {
  final bool isCelsius;

  const ToggleTemperatureUnit(this.isCelsius);

  @override
  List<Object> get props => [isCelsius];
}

class FetchWeatherByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;

  const FetchWeatherByCoordinates(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}
