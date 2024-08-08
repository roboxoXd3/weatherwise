import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/location_service.dart';
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
        _handleError(e, emit);
      }
    });

    // Register event handler for FetchWeatherByCoordinates event
    on<FetchWeatherByCoordinates>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather =
            await getWeather.getByCoordinates(event.latitude, event.longitude);
        final cityName = await LocationService()
            .getCityNameFromCoordinates(event.latitude, event.longitude);
        emit(WeatherLoaded(
          _isCelsius
              ? weather.copyWith(cityName: cityName)
              : _convertWeatherToImperial(weather.copyWith(cityName: cityName)),
        ));
      } catch (e) {
        print('Error fetching weather by coordinates: $e');
        _handleError(e, emit);
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

  void _handleError(Object error, Emitter<WeatherState> emit) {
    print('Error fetching weather: $error');
    if (error.toString().contains('city not found')) {
      emit(const WeatherError('City not found. Please check the city name.'));
    } else {
      emit(const WeatherError('Failed to fetch weather'));
    }
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
