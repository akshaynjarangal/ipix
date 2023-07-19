part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
  
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantListLoading extends RestaurantState {}

class RestaurantListSuccess extends RestaurantState {
  final List<RestaurantsModel> model;
  const RestaurantListSuccess({required this.model});
  @override
  List<Object> get props => [model];
}

class RestaurantListFailed extends RestaurantState {}