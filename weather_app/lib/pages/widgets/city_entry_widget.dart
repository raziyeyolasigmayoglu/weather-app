import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

class CityEntryWidget extends StatefulWidget {
  const CityEntryWidget({Key? key, required this.callBackFunction})
      : super(key: key);

  final Function callBackFunction;

  @override
  _CityEntryWidgetState createState() => _CityEntryWidgetState();
}

class _CityEntryWidgetState extends State<CityEntryWidget> {
  late TextEditingController cityEditController;

  @override
  void initState() {
    super.initState();

    cityEditController = TextEditingController();
  }

  void submitCityName(BuildContext context, String cityName) {
    BlocProvider.of<WeatherCubit>(context).getWeather(cityName);
    widget.callBackFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
        padding: const EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () =>
                    submitCityName(context, cityEditController.text)),
            const SizedBox(width: 10),
            Expanded(
                child: TextField(
                    controller: cityEditController,
                    decoration:
                        const InputDecoration.collapsed(hintText: "Enter City"),
                    onSubmitted: (String city) =>
                        submitCityName(context, city))),
          ],
        ));
  }
}
