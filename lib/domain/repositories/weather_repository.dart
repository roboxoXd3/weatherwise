// lib/domain/repositories/weather_repository.dart

import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String cityName);
}
