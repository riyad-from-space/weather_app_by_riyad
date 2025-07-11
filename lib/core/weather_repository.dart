import 'package:weather_app_by_riyad/core/weather_services.dart';
import 'package:weather_app_by_riyad/model/forecast_model.dart';
import 'package:weather_app_by_riyad/model/weather_model.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository(this.weatherService);
  Future<WeatherResponse> fetchWeather(String cityName) async {
    final data = await weatherService.getWeather(cityName);
    return WeatherResponse.fromJson(data);
  }

  Future<ForecastResponse> fetchForecast(String cityName) async {
    final data = await weatherService.getForecast(cityName);
    return ForecastResponse.fromJson(data);
  }
}
