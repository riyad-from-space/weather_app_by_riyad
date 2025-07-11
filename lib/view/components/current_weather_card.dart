import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentWeatherCard extends StatelessWidget {
  final dynamic weather;

  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (weather.weather.isNotEmpty)
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.weather.first.icon}@4x.png',
                    width: 80,
                    height: 80,
                  ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.name}, ${weather.sys.country}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weather.weather.first.main,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      'ID: ${weather.id}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: weather.main.temp, end: weather.main.temp),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) => Text(
                '${value.toStringAsFixed(1)}°C',
                style: GoogleFonts.poppins(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Feels like: ${weather.main.feelsLike.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label:
                      Text('Min: ${weather.main.tempMin.toStringAsFixed(1)}°C'),
                  backgroundColor: Colors.deepPurple.shade50,
                ),
                const SizedBox(width: 8),
                Chip(
                  label:
                      Text('Max: ${weather.main.tempMax.toStringAsFixed(1)}°C'),
                  backgroundColor: Colors.deepPurple.shade50,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Base: ${weather.base}',
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text('Code: ${weather.cod}',
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
