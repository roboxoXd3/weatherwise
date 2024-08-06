import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/weather.dart';

class ForecastItem extends StatelessWidget {
  final WeatherForecast forecast;

  const ForecastItem({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('h:mm a').format(DateTime.parse(forecast.date)),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          BoxedIcon(
            forecast.icon,
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.temperature}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DailyForecastItem extends StatelessWidget {
  final WeatherForecast forecast;

  const DailyForecastItem({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Weather on ${DateFormat('EEE, MMM d').format(DateTime.parse(forecast.date))}: ${forecast.temperature}°C')),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEE, MMM d')
                      .format(DateTime.parse(forecast.date)),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  DateFormat('h:mm a').format(DateTime.parse(forecast.date)),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                BoxedIcon(
                  forecast.icon,
                  size: 24,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  '${forecast.temperature.toStringAsFixed(1)}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
