import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/favourite.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  final List<Favourite> _favoriteList = [];

  Future<void> getFavorite() async {
    emit(FavouriteLoaded(favoriteList: _favoriteList));
  }

  Future<void> addFavorite(String city) async {
    bool isExist = _favoriteList.any((element) => element.city.contains(city));
    if (!isExist) {
      _favoriteList.add(Favourite(city: city));
    }
    emit(FavouriteLoaded(favoriteList: _favoriteList));
  }

  Future<void> deleteFavorite(String city) async {
    _favoriteList.remove(Favourite(city: city));
    emit(FavouriteLoaded(favoriteList: _favoriteList));
  }
}
