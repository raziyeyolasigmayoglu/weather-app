import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/favorite_cubit.dart';

import 'widgets/indicator_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoriteCubit>(context).getFavorite();
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey.shade800),
        body: Container(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
              if (state is FavoriteInitial) {
                return const IndicatorWidget();
              } else if (state is FavoriteLoaded) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.favoriteList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.blueGrey,
                          child: ListTile(
                              title: Center(
                                  child: Text(state.favoriteList[index].city,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))));
                    });
              } else {
                return const IndicatorWidget();
              }
            })));
  }
}
