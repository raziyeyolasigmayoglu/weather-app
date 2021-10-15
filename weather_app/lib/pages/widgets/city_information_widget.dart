import 'package:flutter/material.dart';

class CityInformationWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(city.toUpperCase(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            const Text('Sunrise',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 5),
            Text(sunrise,
                style: const TextStyle(fontSize: 15, color: Colors.white))
          ]),
          const SizedBox(width: 20),
          Column(children: [
            const Text('Sunset',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 5),
            Text(sunset,
                style: const TextStyle(fontSize: 15, color: Colors.white))
          ]),
        ]),
      ]),
    );
  }
}
