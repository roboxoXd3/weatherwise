import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;
  bool _isCelsius = true;

  WeatherBloc(this.getWeather) : super(WeatherInitial()) {
    // Register event handler for FetchWeather event
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getWeather(event.cityName);
        emit(WeatherLoaded(
            _isCelsius ? weather : _convertWeatherToImperial(weather)));
      } catch (e) {
        emit(const WeatherError('Failed to fetch weather'));
      }
    });

    // Register event handler for ToggleTemperatureUnit event
    on<ToggleTemperatureUnit>((event, emit) {
      _isCelsius = event.isCelsius;
      if (state is WeatherLoaded) {
        final weather = (state as WeatherLoaded).weather;
        emit(WeatherLoaded(
            _isCelsius ? weather : _convertWeatherToImperial(weather)));
      }
    });
  }

  Weather _convertWeatherToImperial(Weather weather) {
    return weather.copyWith(
      temperature: _convertToFahrenheit(weather.temperature),
      hourlyForecast: weather.hourlyForecast
          .map((f) => f.copyWith(
                temperature: _convertToFahrenheit(f.temperature),
              ))
          .toList(),
      dailyForecast: weather.dailyForecast
          .map((f) => f.copyWith(
                temperature: _convertToFahrenheit(f.temperature),
              ))
          .toList(),
    );
  }

  double _convertToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }
}
