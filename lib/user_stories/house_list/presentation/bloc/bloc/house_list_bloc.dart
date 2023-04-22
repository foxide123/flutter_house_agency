import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/distance_to_house_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/get_all_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/get_specific_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/sort_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/dtos/house_search_params.dart';

import '../../../application/logic/favorite_houses_logic.dart';
import '../../../domain/models/house_model.dart';

part 'house_list_event.dart';
part 'house_list_state.dart';

class HouseListBloc extends Bloc<HouseListEvent, HouseListState> {
  final GetAllHousesLogic getAllHousesLogic;
  final GetSpecificHousesLogic getSpecificHousesLogic;
  final DistanceToHouseLogic getDistanceToHouseLogic;
  final SortHousesLogic sortHousesLogic;
  final FavoriteHousesLogic favoriteHousesLogic;

  Future<bool> isOnline() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

  HouseListBloc({
    required this.getAllHousesLogic,
    required this.getSpecificHousesLogic,
    required this.getDistanceToHouseLogic,
    required this.sortHousesLogic,
    required this.favoriteHousesLogic,
  }) : super(Empty()) {
    on<GetAllHouses>(_onGetAllHouses);
    on<GetSpecificHouses>(_onGetSpecificHouses);
    on<GetDistanceToHouse>(_onGetDistanceToHouse);
    on<SortHouses>(_onSortHouses);
    on<AddFavorite>(_onAddFavorite);
    on<GetFavorites>(_onGetFavorites);
  }

  void _onGetAllHouses(
    GetAllHouses event,
    Emitter<HouseListState> emit,
  ) async {
    if(await isOnline()){
      final result = await getAllHousesLogic.getAllHouses();
    result.fold(
      (failure){
        emit(Error(message: failure.toString()));
      },
      (houseList){
        emit(Loaded(listOfHouses: houseList));
      }
    );
    }else{
      emit(NoInternet());
    }
  }

  void _onGetSpecificHouses(
    GetSpecificHouses event,
    Emitter<HouseListState> emit,
  ) async {
    final result = await getSpecificHousesLogic.getSpecificHouses(event.houseSearchParams);
    result.fold(
      (failure){
        emit(NotFound());
      },
      (houseList){
        emit(Loaded(listOfHouses: houseList));
      }
    );
  }

  void _onGetDistanceToHouse(
    GetDistanceToHouse event,
    Emitter<HouseListState> emit,
  ) async {
    final result = await getDistanceToHouseLogic.getDistanceToHouse(event.lat, event.lon);
    result.fold(
      (failure) {
        emit(DistanceLoaded(distance: 0, houseId: 0));
      },
      (distance) {
        emit(DistanceLoaded(distance: distance, houseId: event.houseId));
      },
    );
}
  void _onSortHouses(
    SortHouses event,
    Emitter<HouseListState> emit,
  )async{
    final result = await sortHousesLogic.sortByPrice(event.listOfHouses, ascending: event.ascending);
    result.fold(
      (failure){
        emit(Error(message: failure.toString()));
      },
      (listOfHouses){
        emit(ListSorted(listOfHouses: listOfHouses));
      }
    );
  }


  void _onAddFavorite(
    AddFavorite event,
    Emitter<HouseListState> emit,
  )async{
    final result = await favoriteHousesLogic.addFavorite(event.houseModel);
    result.fold(
      (failure){
        emit(Error(message: failure.toString()));
      },
      (house){
        emit(FavoriteAdded());
      }
    );
  }

  void _onGetFavorites(
    GetFavorites event,
    Emitter<HouseListState> emit,
  )async{
    final result = await favoriteHousesLogic.getAllFavorites();
    result.fold(
      (failure){
        emit(Error(message: failure.toString()));
      },
      (houses){
        emit(FavoritesRetrieved(houses: houses));
      }
    );
  }
}
