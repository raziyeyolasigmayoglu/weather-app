import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/favorite.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final List<Favorite> _favoriteList = [];

  Future<void> getFavorite() async {
    emit(FavoriteLoaded(favoriteList: _favoriteList));
  }

  Future<void> addFavorite(String city) async {
    _favoriteList.add(Favorite(city: city));
    emit(FavoriteLoaded(favoriteList: _favoriteList));
  }
}
