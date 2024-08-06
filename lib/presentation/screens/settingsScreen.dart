import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../style.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Use Celsius'),
              value: _isCelsius,
              onChanged: (bool value) {
                setState(() {
                  _isCelsius = value;
                });
                // Dispatch event to update temperature unit
                context
                    .read<WeatherBloc>()
                    .add(ToggleTemperatureUnit(_isCelsius));
              },
            ),
            // Add more settings options here
          ],
        ),
      ),
    );
  }
}
