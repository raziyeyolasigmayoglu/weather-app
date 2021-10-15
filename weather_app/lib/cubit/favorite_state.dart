part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Favorite> favoriteList;

  FavoriteLoaded({required this.favoriteList}) : super();
}
