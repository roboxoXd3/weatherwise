import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherModel {
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
  final List<WeatherForecastModel> hourlyForecast;
  final List<WeatherForecastModel> dailyForecast;

  WeatherModel({
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

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['city']['name'],
      country: json['city']['country'],
      temperature: _toDouble(json['list'][0]['main']['temp']),
      description: json['list'][0]['weather'][0]['description'],
      humidity: json['list'][0]['main']['humidity'],
      windSpeed: _toDouble(json['list'][0]['wind']['speed']),
      pressure: json['list'][0]['main']['pressure'],
      visibility: json['list'][0]['visibility'],
      sunrise: formatTime(json['city']['sunrise']),
      sunset: formatTime(json['city']['sunset']),
      hourlyForecast: (json['list'] as List).map((data) {
        return WeatherForecastModel.fromJson(data);
      }).toList(),
      dailyForecast: (json['list'] as List).where((data) {
        return data['dt_txt'].contains('12:00:00');
      }).map((data) {
        return WeatherForecastModel.fromJson(data);
      }).toList(),
    );
  }

  static double _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      throw Exception('Unsupported value type');
    }
  }

  static String formatTime(int timestamp) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }
}

class WeatherForecastModel {
  final String date;
  final double temperature;
  final String iconCode;

  WeatherForecastModel({
    required this.date,
    required this.temperature,
    required this.iconCode,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      date: json['dt_txt'],
      temperature: WeatherModel._toDouble(json['main']['temp']),
      iconCode: json['weather'][0]['icon'],
    );
  }

  static IconData _mapStringToWeatherIcon(String input) {
    switch (input.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'rain':
        return WeatherIcons.rain;
      case 'clouds':
        return WeatherIcons.cloud;
      case 'snow':
        return WeatherIcons.snow;
      default:
        return WeatherIcons.cloudy;
    }
  }
}
