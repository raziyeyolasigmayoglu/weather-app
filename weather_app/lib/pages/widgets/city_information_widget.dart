import 'package:flutter/material.dart';

class CityInformationWidget extends StatelessWidget {
  const CityInformationWidget(
      {Key? key,
      required this.date,
      required this.city,
      required this.sunrise,
      required this.sunset})
      : super(key: key);

  final String date;
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
        Text(date,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            )),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            const Text('Sunrise', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            Text(sunrise, style: const TextStyle(color: Colors.white))
          ]),
          const SizedBox(width: 60),
          Column(children: [
            const Text('Sunset', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            Text(sunset, style: const TextStyle(color: Colors.white))
          ]),
        ])
      ]),
    );
  }
}
