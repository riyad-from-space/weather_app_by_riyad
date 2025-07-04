import 'package:http/http.dart' as http;
import 'dart:convert';
class WeatherService{


  static const String apiKey = '0b23df6a7bb8dca638a4b84c5b0445ec';

  Future<Map<String , dynamic>> getWeather(String cityName) async{
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
    final response = await http.get(url);

    if(response.statusCode == 200){
      return json.decode(response.body);

    }else{
      throw Exception("Failed to load data");
    }
  }
}
