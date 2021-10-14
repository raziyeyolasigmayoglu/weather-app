import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';

abstract class IWeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}

class WeatherApi extends IWeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "c5c389452a2eaf047359d0b40421dfb2";

  @override
  Future<Location> getLocation(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&APPID=$apiKey';
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    return Location.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Forecast> getWeather(Location location) async {
    final requestUrl =
        '$endPointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$apiKey';
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return Forecast.fromJson(jsonDecode(response.body));
  }
}
