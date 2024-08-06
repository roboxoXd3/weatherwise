import 'package:flutter/material.dart';

class Weather {
  final String cityName;
  final String country;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final String sunrise;
  final String sunset;
  final List<WeatherForecast> hourlyForecast;
  final List<WeatherForecast> dailyForecast;

  Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  Weather copyWith({
    String? cityName,
    String? country,
    double? temperature,
    String? description,
    int? humidity,
    double? windSpeed,
    int? pressure,
    int? visibility,
    String? sunrise,
    String? sunset,
    List<WeatherForecast>? hourlyForecast,
    List<WeatherForecast>? dailyForecast,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      temperature: temperature ?? this.temperature,
      description: description ?? this.description,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      pressure: pressure ?? this.pressure,
      visibility: visibility ?? this.visibility,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      dailyForecast: dailyForecast ?? this.dailyForecast,
    );
  }
}

class WeatherForecast {
  final String date;
  final double temperature;
  final IconData icon;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.icon,
  });
  WeatherForecast copyWith({
    String? date,
    double? temperature,
    IconData? icon,
  }) {
    return WeatherForecast(
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
    );
  }
}
