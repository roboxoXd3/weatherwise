import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

const String apiKey = 'e97d7f51ddd6720c28283e7ec1ff1b23';

class WeatherDataSource {
  final http.Client client;

  WeatherDataSource(this.client);

  Future<WeatherModel> getWeather(String cityName) async {
    try {
      final response = await client.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        // Detailed error handling
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String errorMessage = responseBody['message'] ?? 'Unknown error';
        print('Failed to load weather: $errorMessage');
        throw Exception('Failed to load weather: $errorMessage');
      }
    } catch (e) {
      // Retry mechanism
      print('Error fetching weather, retrying...');
      return await _retryFetchWeather(cityName);
    }
  }

  Future<WeatherModel> _retryFetchWeather(String cityName) async {
    final response = await client.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric'),
    );

    print('Retry response status: ${response.statusCode}');
    print('Retry response body: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String errorMessage = responseBody['message'] ?? 'Unknown error';
      print('Failed to load weather on retry: $errorMessage');
      throw Exception('Failed to load weather on retry: $errorMessage');
    }
  }

  Future<WeatherModel> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final response = await client.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String errorMessage = responseBody['message'] ?? 'Unknown error';
      print('Failed to load weather by coordinates: $errorMessage');
      throw Exception('Failed to load weather by coordinates: $errorMessage');
    }
  }
}
