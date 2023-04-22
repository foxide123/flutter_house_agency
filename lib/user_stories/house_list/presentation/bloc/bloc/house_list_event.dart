part of 'house_list_bloc.dart';

abstract class HouseListEvent extends Equatable {
  const HouseListEvent();

  @override
  List<Object> get props => [];
}

class GetAllHouses extends HouseListEvent{
  GetAllHouses();
}

class GetSpecificHouses extends HouseListEvent{
  final HouseSearchParams houseSearchParams;

  GetSpecificHouses({required this.houseSearchParams});

  @override
  List<Object> get props => [houseSearchParams];
}

class SortHouses extends HouseListEvent{

  final List<HouseModel> listOfHouses;
  final bool ascending;

  SortHouses({required this.listOfHouses, required this.ascending});

  @override
  List<Object> get props => [listOfHouses, ascending];
}

class GetDistanceToHouse extends HouseListEvent{

  final double lat;
  final double lon;
  final int houseId;

  GetDistanceToHouse({required this.lat, required this.lon, required this.houseId});

  @override
  List<Object> get props => [lat, lon, houseId];
}

class AddFavorite extends HouseListEvent{
  final HouseModel houseModel;
  AddFavorite({required this.houseModel});

  @override
  List<Object> get props => [houseModel];
}

class GetFavorites extends HouseListEvent{
  GetFavorites();
}