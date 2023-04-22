part of 'house_list_bloc.dart';

abstract class HouseListState extends Equatable {
  const HouseListState();
  
  @override
  List<Object> get props => [];
}

class Empty extends HouseListState{}

class Loading extends HouseListState{}

class Loaded extends HouseListState{

  final List<HouseModel> listOfHouses;

  const Loaded({required this.listOfHouses});

  @override
  List<Object> get props => [listOfHouses];
}

class DistanceLoaded extends HouseListState{
  final double distance;
  final int houseId;

  const DistanceLoaded({required this.distance, required this.houseId});

  @override
  List<Object> get props => [distance, houseId];
}

class ListSorted extends HouseListState{
  final List<HouseModel> listOfHouses;

  const ListSorted({required this.listOfHouses});

  @override
  List<Object> get props => [listOfHouses];
}

class Error extends HouseListState{
  final String message;

  const Error({required this.message});

  @override 
  List<Object> get props => [message];
}

class NotFound extends HouseListState{
}

class NoInternet extends HouseListState{
}

class FavoriteAdded extends HouseListState{
  
}

class FavoritesRetrieved extends HouseListState{
  final List<HouseModel> houses;

  const FavoritesRetrieved({required this.houses});

  @override 
  List<Object> get props => [houses];
}