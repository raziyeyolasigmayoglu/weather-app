import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/favourite_cubit.dart';
import 'package:weather_app/utils/extensions.dart';

class CityInformationWidget extends StatefulWidget {
  const CityInformationWidget(
      {Key? key,
      required this.city,
      required this.sunrise,
      required this.sunset})
      : super(key: key);

  final String city;
  final String sunset;
  final String sunrise;

  @override
  _CityInformationWidgetState createState() => _CityInformationWidgetState();
}

class _CityInformationWidgetState extends State<CityInformationWidget> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                isAdded
                    ? BlocProvider.of<FavouriteCubit>(context)
                        .deleteFavorite(widget.city.capitalize())
                    : BlocProvider.of<FavouriteCubit>(context)
                        .addFavorite(widget.city.capitalize());
                setState(() {
                  isAdded ? isAdded = false : isAdded = true;
                });
              },
              icon: Icon(isAdded ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white),
            ))
      ]),
      Text(widget.city.toUpperCase(),
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          )),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          const Text('Sunrise',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 5),
          Text(widget.sunrise,
              style: const TextStyle(fontSize: 15, color: Colors.white))
        ]),
        const SizedBox(width: 20),
        Column(children: [
          const Text('Sunset',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 5),
          Text(widget.sunset,
              style: const TextStyle(fontSize: 15, color: Colors.white))
        ]),
      ]),
    ]);
  }
}
