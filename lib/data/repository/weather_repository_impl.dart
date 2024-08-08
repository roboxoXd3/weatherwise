import 'package:flutter/material.dart';
import 'package:weather_wise/domain/repositories/weather_repository.dart';

import 'package:weather_icons/weather_icons.dart';

import '../../domain/entities/weather.dart';
import '../data_sources/weather_data_source.dart';
import '../models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<Weather> getWeather(String cityName) async {
    final weatherModel = await dataSource.getWeather(cityName);

    return _mapWeatherModelToEntity(weatherModel);
  }

  Future<Weather> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final weatherModel =
        await dataSource.getWeatherByCoordinates(latitude, longitude);

    return _mapWeatherModelToEntity(weatherModel);
  }

  Weather _mapWeatherModelToEntity(WeatherModel weatherModel) {
    return Weather(
      cityName: weatherModel.cityName,
      country: weatherModel.country,
      temperature: weatherModel.temperature,
      description: weatherModel.description,
      humidity: weatherModel.humidity,
      windSpeed: weatherModel.windSpeed,
      pressure: weatherModel.pressure,
      visibility: weatherModel.visibility,
      sunrise: weatherModel.sunrise,
      sunset: weatherModel.sunset,
      hourlyForecast: weatherModel.hourlyForecast.map((forecast) {
        return WeatherForecast(
          date: forecast.date,
          temperature: forecast.temperature,
          icon: getWeatherIcon(forecast.iconCode),
        );
      }).toList(),
      dailyForecast: weatherModel.dailyForecast.map((forecast) {
        return WeatherForecast(
          date: forecast.date,
          temperature: forecast.temperature,
          icon: getWeatherIcon(forecast.iconCode),
        );
      }).toList(),
    );
  }

  IconData getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '02n':
        return WeatherIcons.night_alt_cloudy;
      case '03d':
      case '03n':
        return WeatherIcons.cloud;
      case '04d':
      case '04n':
        return WeatherIcons.cloudy;
      case '09d':
      case '09n':
        return WeatherIcons.showers;
      case '10d':
        return WeatherIcons.day_rain;
      case '10n':
        return WeatherIcons.night_rain;
      case '11d':
      case '11n':
        return WeatherIcons.thunderstorm;
      case '13d':
      case '13n':
        return WeatherIcons.snow;
      case '50d':
      case '50n':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.cloud;
    }
  }
}
