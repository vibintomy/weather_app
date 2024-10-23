part of 'city_bloc_bloc.dart';

sealed class CityBlocState extends Equatable {
  const CityBlocState();

  @override
  List<Object> get props => [];
}

final class CityBlocInitial extends CityBlocState {}

final class CityBlocLoading extends CityBlocState {}

final class CityBlocLoaded extends CityBlocState {
  final List<City> cities;
  CityBlocLoaded(this.cities);
  @override
  List<Object> get props => [cities];
}

class CityError extends CityBlocState {
  final String error;
  CityError(this.error);
   @override
  List<Object> get props => [error];
}
