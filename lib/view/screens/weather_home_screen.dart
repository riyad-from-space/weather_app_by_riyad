import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/forecast_list.dart';
import '../components/search_bar.dart';
import '../components/weather_details.dart';

class WeatherHomeScreen extends ConsumerStatefulWidget {
  final String cityName;

  const WeatherHomeScreen({super.key, required this.cityName});

  @override
  ConsumerState<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends ConsumerState<WeatherHomeScreen> {
  late TextEditingController _controller;
  late String _currentCity;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _currentCity = widget.cityName;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchCity() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      setState(() {
        _currentCity = city;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App", style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.deepPurple,
      ),
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: isDark ? Colors.black : Colors.deepPurple.shade50,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                WeatherSearchBar(
                  controller: _controller,
                  onSearch: _searchCity,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                // Forecast List
                ForecastList(
                  cityName: _currentCity,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                // Weather Details
                Expanded(
                  child: WeatherDetails(cityName: _currentCity),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
