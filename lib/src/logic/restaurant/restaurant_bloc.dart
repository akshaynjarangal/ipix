import 'package:akshaytest/src/data/model/restaurant_model.dart';
import 'package:akshaytest/src/data/repositories/restaurant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<LoadRestaurantsList>((event, emit) async{
      emit(RestaurantListLoading());
      final response = await RestaurantRepository.getRestaurants;
      response.fold((failure) {
        emit(RestaurantListFailed());
      }, (model) {
        emit(RestaurantListSuccess(model: model));
      });
    });
  }
}
