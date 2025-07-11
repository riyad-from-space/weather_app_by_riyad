import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/date_formatter.dart';
import '../../view_model/weather_view_model.dart';
import 'current_weather_card.dart';
import 'info_tile.dart';

class WeatherDetails extends ConsumerWidget {
  final String cityName;

  const WeatherDetails({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherViewModelProvider(cityName));

    return weatherAsync.when(
      data: (weather) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CurrentWeatherCard(weather: weather),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                InfoTile(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '${weather.main.humidity}%',
                ),
                InfoTile(
                  icon: Icons.speed,
                  label: 'Pressure',
                  value: '${weather.main.pressure} hPa',
                ),
                InfoTile(
                  icon: Icons.remove_red_eye,
                  label: 'Visibility',
                  value: '${weather.visibility / 1000} km',
                ),
                InfoTile(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '${weather.wind.speed} m/s',
                ),
                InfoTile(
                  icon: Icons.explore,
                  label: 'Wind Dir',
                  value: '${weather.wind.deg}°',
                ),
                InfoTile(
                  icon: Icons.cloud,
                  label: 'Cloudiness',
                  value: '${weather.clouds.all}%',
                ),
                InfoTile(
                  icon: Icons.wb_sunny,
                  label: 'Sunrise',
                  value: DateFormatter.formatTime(weather.sys.sunrise),
                ),
                InfoTile(
                  icon: Icons.nights_stay,
                  label: 'Sunset',
                  value: DateFormatter.formatTime(weather.sys.sunset),
                ),
                InfoTile(
                  icon: Icons.location_on,
                  label: 'Timezone',
                  value: DateFormatter.formatTimezone(weather.timezone),
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, st) => Center(
        child: Text(
          'Failed to load weather data',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}
