import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:weather_app/application/model/location_model.dart';

class CityService {
  final String baseUrl = 'http://192.168.44.156:8000';

  Future<void> addCity(String name) async {
    print(name);
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'place': name}),
      );
      if (response.statusCode == 200) {
        print('success');
      }
      if (response.statusCode != 200) {
        throw Exception('Failed to add city: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in addCity: $e');
      throw Exception('Failed to add city: $e');
    }
  }

  Future<List<City>> getCities() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body)['locations'];
        print('Fetched cities: $body'); // Debug print

        return body.map((model) => City.fromJson(model))
        .toList()
        .cast<City>();
        
      } else {
        throw Exception('Failed to load cities: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in getCities: $e');
      throw Exception('Failed to load cities: $e');
    }
  }

  Future<void> deleteCityByName(String name) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/deleteCity/$name'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete city: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in deleteCityByName: $e');
      throw Exception('Failed to delete city: $e');
    }
  }
}


class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  dispose() {
    _timer?.cancel();
  }
}