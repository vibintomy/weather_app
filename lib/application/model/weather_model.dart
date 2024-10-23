class Weather {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final String dateTime;
  final String sunRise;
  final String sunSet;
  final double maxTemp;
  final double minTemp;

  Weather({
    required this.cityName,
    required this.dateTime,
    required this.temperature,
    required this.weatherCondition,
    required this.sunRise,
    required this.sunSet,
    required this.maxTemp,
    required this.minTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '', 
      dateTime: DateTime.now().toIso8601String(), 
      temperature: (json['main']['temp'] as num).toDouble(), 
      weatherCondition: json['weather'][0]['main'] ?? '', 
      sunRise: json['sys']['sunrise'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000).toIso8601String()
          : '',
      sunSet: json['sys']['sunset'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000).toIso8601String()
          : '',
      maxTemp: (json['main']['temp_max'] as num).toDouble(), 
      minTemp: (json['main']['temp_min'] as num).toDouble(), 
    );
  }
}
