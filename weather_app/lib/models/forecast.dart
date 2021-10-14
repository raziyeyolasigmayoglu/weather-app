import 'weather.dart';

class Forecast {
  final DateTime? lastUpdated;
  final List<Weather> daily;
  final Weather? current;
  final bool? isDayTime;
  String city;
  final DateTime? sunset;
  final DateTime? sunrise;

  Forecast(
      {this.lastUpdated,
      this.daily = const [],
      this.current,
      this.city = '',
      this.isDayTime,
      this.sunrise,
      this.sunset});

  static Forecast fromJson(dynamic json) {
    var weather = json['current']['weather'][0];
    var date =
        DateTime.fromMillisecondsSinceEpoch(json['current']['dt'] * 1000);

    var sunrise =
        DateTime.fromMillisecondsSinceEpoch(json['current']['sunrise'] * 1000);

    var sunset =
        DateTime.fromMillisecondsSinceEpoch(json['current']['sunset'] * 1000);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);

    // get the forecast for the next 3 days, excluding the current day
    bool hasDaily = json['daily'] != null;
    List<Weather> tempDaily = [];
    if (hasDaily) {
      List items = json['daily'];
      tempDaily = items
          .map((item) => Weather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
    }

    var currentForcast = Weather(
        cloudiness: int.parse(json['current']['clouds'].toString()),
        temp: json['current']['temp'].toDouble(),
        condition: Weather.mapStringToWeatherCondition(
            weather['main'], int.parse(json['current']['clouds'].toString())),
        description: weather['description'],
        feelLikeTemp: json['current']['feels_like'],
        date: date,
        sunrise: sunrise,
        sunset: sunset);

    return Forecast(
        lastUpdated: DateTime.now(),
        current: currentForcast,
        daily: tempDaily,
        isDayTime: isDay,
        sunset: sunset,
        sunrise: sunrise);
  }
}
