import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../domain/entities/weather.dart';
import '../../style.dart';

class WeatherDetailsGrid extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsGrid({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.75,
      padding: const EdgeInsets.all(8.0),
      children: [
        _buildWeatherDetail(
            WeatherIcons.humidity, 'Humidity', '${weather.humidity}%', context),
        _buildWeatherDetail(WeatherIcons.strong_wind, 'Wind',
            '${weather.windSpeed.toStringAsFixed(1)} m/s', context),
        _buildWeatherDetail(WeatherIcons.barometer, 'Pressure',
            '${weather.pressure} hPa', context),
        _buildWeatherDetail(WeatherIcons.day_sunny, 'Visibility',
            '${weather.visibility / 1000} km', context),
        _buildWeatherDetail(
            WeatherIcons.sunrise, 'Sunrise', weather.sunrise, context),
        _buildWeatherDetail(
            WeatherIcons.sunset, 'Sunset', weather.sunset, context),
      ],
    );
  }

  Widget _buildWeatherDetail(
      IconData icon, String label, String value, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label: $value')),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxedIcon(icon, size: 20, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: detailLabelTextStyle,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: detailValueTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
