part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class WeatherBlocLoading extends WeatherBlocState {}

final class WeatherLoaded extends WeatherBlocState {
  final String city;
  final int temperature;
  const WeatherLoaded(this.city, this.temperature);

  @override
  List<Object> get props => [city, temperature];
}

final class WeatherBlocFailure extends WeatherBlocState {
   final String error;

  WeatherBlocFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class WeatherBlocSuccess extends WeatherBlocState {
  final Weather weather;
  const WeatherBlocSuccess(this.weather);
   @override
  List<Object> get props => [weather];
}
