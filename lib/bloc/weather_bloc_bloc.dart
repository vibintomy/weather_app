import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/application/model/weather_model.dart';
import 'package:http/http.dart' as http;

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        final requestUrl =     'https://api.openweathermap.org/data/2.5/weather?lat=${event.position.latitude}&lon=${event.position.longitude}&appid=21f22329cafed1e374f9f58871daf58e&units=metric';
        
        // Print the request URL for debugging
        print('Requesting weather data from: $requestUrl');

        final response = await http.get(Uri.parse(requestUrl));

        // Check the response status
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final weather = Weather.fromJson(jsonData);
          emit(WeatherBlocSuccess(weather));
        } else if (response.statusCode == 401) {
          emit(WeatherBlocFailure('Unauthorized: Please check your API key.'));
        } else {
          emit(WeatherBlocFailure('Failed to load weather data. Status code: ${response.statusCode}'));
        }
      } catch (e) {
        emit(WeatherBlocFailure('Error: $e'));
      }
    });

    on<FetchWeatherBycityName>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        final requestUrl = 'https://api.openweathermap.org/data/2.5/weather'
            '?q=${event.cityName}&appid=21f22329cafed1e374f9f58871daf58e&units=metric';

        // Print the request URL for debugging
        print('Requesting weather data for city: $requestUrl');

        final response = await http.get(Uri.parse(requestUrl));

        // Check the response status
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final weather = Weather.fromJson(jsonData);
          emit(WeatherBlocSuccess(weather));
        } else if (response.statusCode == 401) {
          emit(WeatherBlocFailure('Unauthorized: Please check your API key.'));
        } else {
          emit(WeatherBlocFailure('Failed to load weather data. Status code: ${response.statusCode}'));
        }
      } catch (e) {
        emit(WeatherBlocFailure('Error: $e'));
      }
    });
  }
}
