import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_by_riyad/core/weather_repository.dart';
import 'package:weather_app_by_riyad/core/weather_services.dart';
import 'package:weather_app_by_riyad/model/weather_model.dart';

final weatherServiceProvider = Provider<WeatherService>((ref)=>WeatherService());
final weatherRepositoryProvider = Provider<WeatherRepository>((ref)=>WeatherRepository(ref.read(weatherServiceProvider)));
final weatherViewModelProvider = FutureProvider.family<WeatherResponse,String>((ref,cityName){
  final repository = ref.read(weatherRepositoryProvider);
  return repository.fetchWeather(cityName);
});