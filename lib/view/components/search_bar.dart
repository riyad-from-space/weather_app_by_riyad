import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final bool isDark;

  const WeatherSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        hintText: "Enter city name",
        hintStyle: GoogleFonts.poppins(),
        filled: true,
        fillColor:
            (isDark ? Colors.white10 : Colors.deepPurple.withOpacity(0.05)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearch,
        ),
      ),
      onSubmitted: (_) => onSearch(),
    );
  }
}
