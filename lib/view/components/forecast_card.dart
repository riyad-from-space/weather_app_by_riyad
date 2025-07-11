import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/forecast_model.dart';
import '../../utils/date_formatter.dart';

class ForecastCard extends StatelessWidget {
  final ForecastItem day;
  final bool isDark;
  final VoidCallback onTap;

  const ForecastCard({
    super.key,
    required this.day,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final weather = day.weather.first;
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms),
        SlideEffect(begin: const Offset(0, 0.2), duration: 500.ms),
      ],
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Card(
            color: isDark
                ? Colors.deepPurple.shade900.withOpacity(0.8)
                : Colors.white.withOpacity(0.85),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Container(
              width: 140,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                    width: 60,
                    height: 60,
                    placeholder: (ctx, _) => const CircularProgressIndicator(),
                    errorWidget: (ctx, _, __) => const Icon(Icons.error),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormatter.formatDayOfWeek(day.dt),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '${day.main.temp.toStringAsFixed(1)}°C',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  Text(
                    weather.main,
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
