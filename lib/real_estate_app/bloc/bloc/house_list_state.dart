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
  final Map<int, String> distances;

  const DistanceLoaded({required this.distances});

  @override
  List<Object> get props => [distances];
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
  final HouseModel house;
  const FavoriteAdded({required this.house});

  @override
  List<Object> get props => [house];
}

class FavoriteRemoved extends HouseListState{
  final HouseModel house;
  const FavoriteRemoved({required this.house});

  @override
  List<Object> get props => [house];
}

class FavoritesRetrieved extends HouseListState{
  final List<HouseModel> houses;

  const FavoritesRetrieved({required this.houses});

  @override 
  List<Object> get props => [houses];
}