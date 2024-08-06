import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../style.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/weather_details_grid.dart';
import '../widgets/forecast_item.dart';

class HomeScreen extends StatefulWidget {
  final String cityName;

  const HomeScreen({super.key, required this.cityName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();

    // Fetch weather for the provided city name
    context.read<WeatherBloc>().add(FetchWeather(widget.cityName));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return const Center(
                  child: Text(
                    'Please enter a city name',
                    style: cityTextStyle,
                  ),
                );
              } else if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherLoaded) {
                return FadeTransition(
                  opacity: _fadeInAnimation,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 120.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: const Text(
                            'WeatherWise',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          background: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [primaryColor, secondaryColor],
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.weather.cityName}, ${state.weather.country}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.weather.temperature.toStringAsFixed(1)}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: BoxedIcon(
                                      WeatherIcons.day_sunny,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                state.weather.description,
                                style: weatherTextStyle,
                              ),
                              const SizedBox(height: 24),
                              WeatherDetailsGrid(weather: state.weather),
                              const SizedBox(height: 32),
                              const Text(
                                'Hourly Forecast',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.weather.hourlyForecast.length,
                                  itemBuilder: (context, index) {
                                    return ForecastItem(
                                      forecast:
                                          state.weather.hourlyForecast[index],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'Daily Forecast',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: state.weather.dailyForecast
                                    .map((day) =>
                                        DailyForecastItem(forecast: day))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is WeatherError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
