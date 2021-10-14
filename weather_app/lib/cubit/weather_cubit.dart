import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/services/repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final IRepository _repository;
  WeatherCubit(this._repository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherInitial());
      final forecast = await _repository.getWeather(cityName);
      emit(WeatherLoaded(forecast: forecast));
    } on NetworkException {
      emit(WeatherError("Couldn't fetch forecast. Is the device online?"));
    }
  }
}
