import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/application/controller/weather_controller.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/cityServices/bloc/city_bloc_bloc.dart';
import 'package:weather_app/screens/saved_screen.dart';

class HomePage extends StatelessWidget {
  final Position initialPosition;
 
  final CityService cityService = CityService();
  HomePage({super.key, required this.initialPosition});
  final TextEditingController _searchController = TextEditingController();

  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          title: Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 40,
                child: CupertinoSearchTextField(
                  controller: _searchController,
                  placeholder: 'Search',
                  onChanged: (query) {
                    BlocProvider.of<WeatherBlocBloc>(context)
                        .add(FetchWeatherBycityName(query));
                  },
                  onSubmitted: (query) {
                    BlocProvider.of<WeatherBlocBloc>(context)
                        .add(FetchWeatherBycityName(query));
                  },
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 95, 31, 31),
                      borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              )),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<CityBlocBloc>(context)
                        .add(Addcity(_searchController.text));

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SavedScreen()));
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.orange),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                      builder: (context, state) {
                        if (state is WeatherBlocSuccess) {
                       
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '📍 ${state.weather.cityName}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _searchController.clear();
                                          BlocProvider.of<WeatherBlocBloc>(
                                                  context)
                                              .add(FetchWeather(
                                                  initialPosition));
                                        },
                                        icon: const Icon(
                                          Icons.home,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          BlocProvider.of<CityBlocBloc>(context)
                                              .add(Addcity(_searchController.text));

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SavedScreen()));
                                        },
                                        icon: const Icon(
                                          Icons.bookmark,
                                          color: Colors.white,
                                          size: 30,
                                        ))
                                  ],
                                ),
                                Container(
                                    child: Lottie.asset(getWeatherAnimation(
                                        state.weather.weatherCondition
                                            .toUpperCase()))),
                                Center(
                                    child: Text(
                                  '${state.weather.temperature.round()} °C',
                                  style: const TextStyle(
                                      fontSize: 45,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                                Center(
                                    child: Text(
                                  state.weather.weatherCondition.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    DateFormat('EEEE dd ·').add_jm().format(
                                        DateTime.parse(state.weather.dateTime)),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/11.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Sunrise',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              DateFormat().add_jm().format(
                                                  DateTime.parse(
                                                      state.weather.sunRise)),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/12.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Sunset',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              DateFormat().add_jm().format(
                                                  DateTime.parse(
                                                      state.weather.sunSet)),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/13.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Temp Max',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "${state.weather.maxTemp.round()} °C",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/14.png',
                                          scale: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Temp Min',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "${state.weather.minTemp.round()} °C",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

String getWeatherAnimation(String mainCondition) {
  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/Lottie/windy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/Lottie/sun with rain.json';
    case 'thunderstorm':
      return 'assets/Lottie/thunder.json';
    case 'clear':
      return 'assets/Lottie/sunny.json';
    default:
      return 'assets/Lottie/sunny.json';
  }
}
