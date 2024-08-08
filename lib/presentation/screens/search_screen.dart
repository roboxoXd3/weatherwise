// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/location_service.dart';
// import '../../style.dart';
// import '../bloc/weather_bloc.dart';
// import '../bloc/weather_event.dart';
// import 'home_screen.dart';
// import 'settingsScreen.dart';
//
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _searchController = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WeatherWise'),
//         backgroundColor: primaryColor,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [primaryColor, secondaryColor],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'WeatherWise',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                   child: TextField(
//                     controller: _searchController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: 'Enter city name',
//                       hintStyle: const TextStyle(color: Colors.white70),
//                       prefixIcon: const Icon(Icons.search, color: Colors.white),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.2),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     final cityName = _searchController.text.trim();
//                     if (cityName.isNotEmpty) {
//                       context.read<WeatherBloc>().add(FetchWeather(cityName));
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HomeScreen(cityName: cityName),
//                         ),
//                       );
//                     } else {
//                       // Show a snackbar or alert indicating the city name can't be empty
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter a city name'),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                     backgroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text('Search'),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       final position =
//                           await LocationService().getCurrentLocation();
//                       final cityName = await LocationService()
//                           .getCityNameFromCoordinates(
//                               position.latitude, position.longitude);
//                       context.read<WeatherBloc>().add(
//                             FetchWeatherByCoordinates(
//                                 position.latitude, position.longitude),
//                           );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HomeScreen(cityName: cityName),
//                         ),
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content:
//                               Text('Failed to get location: ${e.toString()}'),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                     backgroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text('Use Current Location'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/location_service.dart';
import '../../style.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import 'home_screen.dart';
import 'settingsScreen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherWise'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'WeatherWise',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final cityName = _searchController.text.trim();
                    if (cityName.isNotEmpty) {
                      // final formattedCityName = cityName.contains(',')
                      //     ? cityName
                      //     : '$cityName,IN'; // Append country code if not present
                      context.read<WeatherBloc>().add(FetchWeather(cityName));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              // HomeScreen(cityName: formattedCityName),
                              HomeScreen(cityName: cityName),
                        ),
                      );
                    } else {
                      // Show a snackbar or alert indicating the city name can't be empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a city name'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Search'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final position =
                          await LocationService().getCurrentLocation();
                      final cityName = await LocationService()
                          .getCityNameFromCoordinates(
                              position.latitude, position.longitude);
                      context.read<WeatherBloc>().add(
                            FetchWeatherByCoordinates(
                                position.latitude, position.longitude),
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(cityName: cityName),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Failed to get location: ${e.toString()}'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Use Current Location'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
