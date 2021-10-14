enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  mist,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class Weather {
  final WeatherCondition condition;
  final String description;
  final double temp;
  final double feelLikeTemp;
  final int cloudiness;
  final DateTime date;
  final DateTime sunrise;
  final DateTime sunset;

  Weather(
      {required this.condition,
      required this.description,
      required this.temp,
      required this.feelLikeTemp,
      required this.cloudiness,
      required this.date,
      required this.sunrise,
      required this.sunset});

  static Weather fromDailyJson(dynamic daily) {
    var cloudiness = daily['clouds'];
    var weather = daily['weather'][0];

    return Weather(
        condition: mapStringToWeatherCondition(weather['main'], cloudiness),
        description: weather['description'],
        cloudiness: cloudiness,
        temp: daily['temp']['day'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000),
        sunrise: DateTime.fromMillisecondsSinceEpoch(daily['sunrise'] * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(daily['sunset'] * 1000),
        feelLikeTemp: daily['feels_like']['day'].toDouble());
  }

  static WeatherCondition mapStringToWeatherCondition(
      String input, int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      default:
        condition = WeatherCondition.unknown;
    }

    return condition;
  }
}
