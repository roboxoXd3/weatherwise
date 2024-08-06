// lib/data/data_sources/weather_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherDataSource {
  final http.Client client;

  WeatherDataSource(this.client);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await client.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=e97d7f51ddd6720c28283e7ec1ff1b23&units=metric'),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
