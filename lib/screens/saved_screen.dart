import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/cityServices/bloc/city_bloc_bloc.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FetchCities event to load the saved cities
    BlocProvider.of<CityBlocBloc>(context).add(FetchCities());

    return Scaffold(
      backgroundColor: Colors.grey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Saved Locations',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(9, 5, 105, 1),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(116, 23, 7, 1),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 700,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(194, 74, 41, 1),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            BlocBuilder<CityBlocBloc, CityBlocState>(
              builder: (context, state) {
                if (state is CityBlocLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CityBlocLoaded) {
                  if (state.cities.isEmpty) {
                    return const Center(
                        child: Text(
                      'No saved cities',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ));
                  }
                  return ListView.builder(
                    itemCount: state.cities.length,
                    itemBuilder: (context, index) {
                      final city = state.cities[index];
                      final formattedDate = DateFormat('EEEE dd •').add_jm();

                      return Card(
                        color:
                            Colors.grey[850], // Background color for the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            city.place,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          // subtitle: Text(
                          //   formattedDate,
                          //   style: const TextStyle(
                          //     color: Colors.white70,
                          //     fontSize: 14,
                          //   ),
                          // ),
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     BlocProvider.of<CityBlocBloc>(context)
                          //         .add(DeleteCityByName(city.place));
                          //   },
                          //   icon: Icon(
                          //     Icons.star,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ),
                      );
                    },
                  );
                } else if (state is CityError) {
                  return Center(
                      child: Text(state.error,
                          style: const TextStyle(color: Colors.red)));
                }
                return Container(); // Fallback widget if no state matches
              },
            ),
          ],
        ),
      ),
    );
  }
}
