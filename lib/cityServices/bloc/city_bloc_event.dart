part of 'city_bloc_bloc.dart';

abstract class CityBlocEvent extends Equatable {
  const CityBlocEvent();

  @override
  List<Object> get props => [];
}

class Addcity extends CityBlocEvent {
  final String name;
  Addcity(this.name);
  @override
  List<Object> get props => [name];
}

class DeleteCityByName extends CityBlocEvent {
  final String cityName;
  DeleteCityByName(this.cityName);
   @override
  List<Object> get props => [cityName];
}

class FetchCities extends CityBlocEvent{}
