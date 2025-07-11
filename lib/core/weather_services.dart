import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '0a81dcce4dcbb4eaa4ed7e0dd0de8619';

  Future<Map<String, dynamic>> getWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);

    print('Weather API status: ${response.statusCode}');
    print('Weather API body: ${response.body}');
    print('Using API key: $apiKey');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Map<String, dynamic>> getForecast(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);

    print('Forecast API status: ${response.statusCode}');
    print('Forecast API body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load forecast");
    }
  }
}
