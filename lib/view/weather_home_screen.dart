import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/weather_view_model.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  final String cityName;

  const WeatherScreen({super.key, required this.cityName});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
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
    final weatherAsync = ref.watch(weatherViewModelProvider(_currentCity));

    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter city name",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchCity,
                ),
              ),
              onSubmitted: (_) => _searchCity(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: weatherAsync.when(
                data: (weather) => ListView(
                  children: [
                    Text("City: $_currentCity",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Temperature: ${weather.main.temp} K"),
                    Text("Condition: ${weather.weather.first.description}"),
                    Text("Humidity: ${weather.main.humidity}%"),
                    Text("Wind Speed: ${weather.wind.speed} m/s"),
                    Text("Cloudiness: ${weather.clouds.all}%"),
                    Text(
                        "Sunrise: ${DateTime.fromMillisecondsSinceEpoch(weather.sys.sunrise * 1000)}"),
                    Text(
                        "Sunset: ${DateTime.fromMillisecondsSinceEpoch(weather.sys.sunset * 1000)}"),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Error: $e")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
