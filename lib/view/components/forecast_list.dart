import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../view_model/weather_view_model.dart';
import '../screens/forecast_detail_screen.dart';
import 'forecast_card.dart';

class ForecastList extends ConsumerWidget {
  final String cityName;
  final bool isDark;

  const ForecastList({
    super.key,
    required this.cityName,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastAsync = ref.watch(forecastProvider(cityName));

    return forecastAsync.when(
      data: (forecast) => SizedBox(
        height: 170,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: forecast.dailyForecasts.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, i) {
            final day = forecast.dailyForecasts[i];
            return ForecastCard(
              day: day,
              isDark: isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ForecastDetailScreen(day: day, cityName: cityName),
                  ),
                );
              },
            );
          },
        ),
      ),
      loading: () => SizedBox(
        height: 170,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, i) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: const SizedBox(width: 120, height: 150),
            ),
          ),
        ),
      ),
      error: (e, st) => Center(
          child: Text('Failed to load forecast', style: GoogleFonts.poppins())),
    );
  }
}
