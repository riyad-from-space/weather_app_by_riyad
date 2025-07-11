import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/forecast_model.dart';
import '../../utils/date_formatter.dart';
import '../components/info_tile.dart';

class ForecastDetailScreen extends StatelessWidget {
  final ForecastItem day;
  final String cityName;

  const ForecastDetailScreen({
    super.key,
    required this.day,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final weather = day.weather.first;
    return Scaffold(
      appBar: AppBar(
        title: Text('$cityName - ${DateFormatter.formatDayOfWeek(day.dt)}',
            style: GoogleFonts.poppins()),
        backgroundColor: isDark ? Colors.black : Colors.deepPurple,
      ),
      body: Stack(
        children: [
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: isDark
                      ? Colors.deepPurple.shade900.withOpacity(0.8)
                      : Colors.white.withOpacity(0.85),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                              width: 80,
                              height: 80,
                              placeholder: (ctx, _) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (ctx, _, __) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cityName,
                                    style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text(weather.main,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.deepPurple)),
                                Text(DateFormatter.formatDayOfWeek(day.dt),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('${day.main.temp.toStringAsFixed(1)}°C',
                            style: GoogleFonts.poppins(
                                fontSize: 48, fontWeight: FontWeight.bold)),
                        Text(
                            'Feels like: ${day.main.feelsLike.toStringAsFixed(1)}°C',
                            style: GoogleFonts.poppins(fontSize: 16)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Chip(
                              label: Text(
                                  'Min: ${day.main.tempMin.toStringAsFixed(1)}°C',
                                  style: GoogleFonts.poppins()),
                              backgroundColor: Colors.deepPurple.shade50,
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(
                                  'Max: ${day.main.tempMax.toStringAsFixed(1)}°C',
                                  style: GoogleFonts.poppins()),
                              backgroundColor: Colors.deepPurple.shade50,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Time: ${day.dtTxt}',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    InfoTile(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '${day.main.humidity}%'),
                    InfoTile(
                        icon: Icons.speed,
                        label: 'Pressure',
                        value: '${day.main.pressure} hPa'),
                    InfoTile(
                        icon: Icons.air,
                        label: 'Wind',
                        value: '${day.wind.speed} m/s'),
                    InfoTile(
                        icon: Icons.explore,
                        label: 'Wind Dir',
                        value: '${day.wind.deg}°'),
                    InfoTile(
                        icon: Icons.air_outlined,
                        label: 'Wind Gust',
                        value: '${day.wind.gust} m/s'),
                    InfoTile(
                        icon: Icons.cloud,
                        label: 'Cloudiness',
                        value: '${day.clouds.all}%'),
                    InfoTile(
                        icon: Icons.remove_red_eye,
                        label: 'Visibility',
                        value: '${day.visibility / 1000} km'),
                    InfoTile(
                        icon: Icons.umbrella,
                        label: 'Precip. Prob.',
                        value: '${(day.pop * 100).toStringAsFixed(0)}%'),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.deepPurple.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weather Details',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold)),
                        ...day.weather.map((w) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                  '• ${w.main}: ${w.description} (icon: ${w.icon}, id: ${w.id})',
                                  style: GoogleFonts.poppins()),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
