import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

class WeatherSummaryWidget extends StatelessWidget {
  const WeatherSummaryWidget(
      {Key? key,
      required this.condition,
      required this.temp,
      required this.feelsLike})
      : super(key: key);

  final WeatherCondition condition;
  final double temp;
  final double feelsLike;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _mapWeatherConditionToImage(condition),
        Column(
          children: [
            Text(
              '${_formatTemperature(temp)}°',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(feelsLike)}°',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  String _formatTemperature(double t) {
    // ignore: unnecessary_null_comparison
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        image = Image.asset('assets/images/clear.png');
        break;
      case WeatherCondition.snow:
        image = Image.asset('assets/images/snow.png');
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/images/cloudy.png');
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
      case WeatherCondition.rain:
        image = Image.asset('assets/images/rainy.png');
        break;
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/images/thunderstorm.png');
        break;
      case WeatherCondition.unknown:
        image = Image.asset('assets/images/clear.png');
        break;
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
