// lib/domain/use_cases/get_weather.dart

import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<Weather> call(String cityName) async {
    return await repository.getWeather(cityName);
  }
}
