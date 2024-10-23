import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/application/controller/weather_controller.dart';
import 'package:weather_app/application/model/location_model.dart';

part 'city_bloc_event.dart';
part 'city_bloc_state.dart';

class CityBlocBloc extends Bloc<CityBlocEvent, CityBlocState> {
  final CityService cityService;
  CityBlocBloc(this.cityService) : super(CityBlocInitial()) {
    on<Addcity>((event, emit) async {
      try {
        emit(CityBlocLoading());

        await cityService.addCity(event.name);
        
        print('vibin');
        final cities = await cityService.getCities();
        emit(CityBlocLoaded(cities));
      } catch (error) {
        emit(CityError(error.toString()));
      }
    });

    on<FetchCities>((event, emit) async {
      try {
        emit(CityBlocLoading());
        final cities = await cityService.getCities();
        emit(CityBlocLoaded(cities));
      } catch (error) {
        emit(CityError(error.toString()));
      }
    });
    on<DeleteCityByName>((event, emit) async {
      try {
        await cityService.deleteCityByName(event.cityName);
        final cities = await cityService.getCities();
        emit(CityBlocLoaded(cities));
      } catch (error) {
        emit(CityError(error.toString()));
      }
    });
  }
}
