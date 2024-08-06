import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'data/repository/weather_repository_impl.dart';
import 'data/data_sources/weather_data_source.dart';
import 'domain/usecases/get_weather.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'presentation/screens/search_screen.dart';

void main() {
  final WeatherRepositoryImpl repository = WeatherRepositoryImpl(
    WeatherDataSource(
      http.Client(),
    ),
  );
  runApp(
    MyApp(repository: repository),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(GetWeather(repository)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeatherWise',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const SearchScreen(),
      ),
    );
  }
}
