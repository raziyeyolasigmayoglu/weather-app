import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';
import 'widgets/city_information_widget.dart';
import 'widgets/city_entry_widget.dart';
import 'widgets/daily_summary_widget.dart';
import 'widgets/gradient_container_widget.dart';
import 'widgets/last_update_widget.dart';
import 'widgets/weather_description_widget.dart';
import 'widgets/weather_summary_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<void>? _refreshCompleter;
  late Forecast _forecast;
  bool isSelectedDate = false;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  void selectedDate(Weather weather) {
    isSelectedDate = true;
    setState(() {
      _forecast.date = weather.date;
      _forecast.sunrise = weather.sunrise;
      _forecast.sunset = weather.sunset;
      _forecast.current = weather;
    });
  }

  void changeCity() {
    setState(() {
      isSelectedDate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherCubit>(context).getWeather('London');
    String errorMessage = '';
    return Scaffold(
        body: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
      if (state is WeatherError) {
        errorMessage = state.message;
      }
    }, builder: (context, state) {
      if (state is WeatherInitial) {
        return buildBusyIndicator();
      } else if (state is WeatherLoading) {
        return buildBusyIndicator();
      } else if (state is WeatherLoaded) {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
        if (!isSelectedDate) {
          _forecast = state.forecast;
        }
        return _buildGradientContainer(state.forecast.current.condition,
            state.forecast.isDayTime, buildColumnWithData());
      } else {
        return _buildGradientContainer(
            WeatherCondition.clear, false, buildColumnWithError(errorMessage));
      }
    }));
  }

  Widget buildColumnWithError(String message) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(children: <Widget>[
          CityEntryWidget(callBackFunction: changeCity),
          Center(
              child: Text(message,
                  style: const TextStyle(fontSize: 21, color: Colors.white)))
        ]));
  }

  Widget buildColumnWithData() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
            color: Colors.transparent,
            backgroundColor: Colors.transparent,
            onRefresh: () => refreshWeather(_forecast.city),
            child: ListView(
              children: <Widget>[
                CityEntryWidget(callBackFunction: changeCity),
                Column(children: [
                  CityInformationWidget(
                      date: _forecast.date,
                      city: _forecast.city,
                      sunrise: _forecast.sunrise,
                      sunset: _forecast.sunset),
                  const SizedBox(height: 50),
                  WeatherSummaryWidget(
                      condition: _forecast.current.condition,
                      temp: _forecast.current.temp,
                      feelsLike: _forecast.current.feelLikeTemp),
                  const SizedBox(height: 20),
                  WeatherDescriptionWidget(
                      weatherDescription: _forecast.current.description),
                  const SizedBox(height: 100),
                  buildDailySummary(_forecast.daily),
                  LastUpdatedWidget(lastUpdatedOn: _forecast.lastUpdated),
                ]),
              ],
            )));
  }

  Widget buildBusyIndicator() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: dailyForecast.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () => selectedDate(dailyForecast[index]),
                  child: DailySummaryWidget(weather: dailyForecast[index]));
            }));
  }

  Future<void> refreshWeather(String cityName) {
    if (!isSelectedDate) {
      BlocProvider.of<WeatherCubit>(context).getWeather(cityName);
    }
    return _refreshCompleter!.future;
  }

  GradientContainerWidget _buildGradientContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainerWidget container;
    if (!isDayTime) {
      container = GradientContainerWidget(color: Colors.blueGrey, child: child);
    } else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container =
              GradientContainerWidget(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container =
              GradientContainerWidget(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container =
              GradientContainerWidget(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container =
              GradientContainerWidget(color: Colors.deepPurple, child: child);
          break;
        default:
          container =
              GradientContainerWidget(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}
