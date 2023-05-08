import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import '../../application/logic/distance_to_house_logic.dart';
import '../../application/logic/favorite_houses_logic.dart';
import '../../application/logic/get_all_houses_logic.dart';
import '../../application/logic/get_specific_houses_logic.dart';
import '../../application/logic/sort_houses_logic.dart';
import '../../domain/dtos/house_search_params.dart';
import '../../domain/models/house_model.dart';
part 'house_list_event.dart';
part 'house_list_state.dart';

class HouseListBloc extends Bloc<HouseListEvent, HouseListState> {
  final GetAllHousesLogic getAllHousesLogic;
  final GetSpecificHousesLogic getSpecificHousesLogic;
  final DistanceToHouseLogic getDistanceToHouseLogic;
  final SortHousesLogic sortHousesLogic;
  final FavoriteHousesLogic favoriteHousesLogic;

  List<HouseModel> savedHouses = [];
  List<HouseModel> favoriteHouses = [];
  Map<int, String> distances = {};
  LocationData? lastLocation = null;

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
    on<GetDistancesToHouses>(_onGetDistancesToHouses);
    on<SortHouses>(_onSortHouses);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<GetFavorites>(_onGetFavorites);
  }

  void _onGetAllHouses(
    GetAllHouses event,
    Emitter<HouseListState> emit,
  ) async {
    if (await isOnline()) {
      if (savedHouses.isNotEmpty) {
        emit(Loaded(listOfHouses: savedHouses));
      } else {
        final result = await getAllHousesLogic.getAllHouses();
        result.fold((failure) {
          emit(Error(message: failure.toString()));
        }, (houseList) {
          savedHouses = houseList;
          emit(Loaded(listOfHouses: houseList));
        });
      }
    } else {
      emit(NoInternet());
    }
  }

  void _onGetSpecificHouses(
    GetSpecificHouses event,
    Emitter<HouseListState> emit,
  ) async {
    final result =
        await getSpecificHousesLogic.getSpecificHouses(event.houseSearchParams);
    result.fold((failure) {
      emit(NotFound());
    }, (houseList) {
      emit(Loaded(listOfHouses: houseList));
    });
  }

  void _onGetDistancesToHouses(
    GetDistancesToHouses event,
    Emitter<HouseListState> emit,
  ) async {
    final currentLocation = await getDistanceToHouseLogic.getCurrentLocation();
    if (currentLocation.isLeft()) {
      emit(Error(message: 'Error getting current location'));
    }
    final LocationData userLocationData =
        currentLocation.getOrElse(() => LocationData.fromMap({}));

    if (lastLocation!= null &&
     lastLocation == userLocationData
      && distances.isNotEmpty) {
      emit(DistanceLoaded(distances: distances));
    } else {
      lastLocation = userLocationData;
      for (final house in event.houses) {
        final result = await getDistanceToHouseLogic.getDistanceToHouse(
            house.latitude.toDouble(), house.longitude.toDouble());
        result.fold(
          (failure) {
            distances[house.id] = '0';
          },
          (distance) {
            distances[house.id] = distance.toStringAsFixed(2);
          },
        );
      }
      emit(DistanceLoaded(distances: distances));
    }
  }

  void _onSortHouses(
    SortHouses event,
    Emitter<HouseListState> emit,
  ) async {
    final result = await sortHousesLogic.sortByPrice(event.listOfHouses,
        ascending: event.ascending);
    result.fold((failure) {
      emit(Error(message: failure.toString()));
    }, (listOfHouses) {
      emit(ListSorted(listOfHouses: listOfHouses));
    });
  }

  void _onAddFavorite(
    AddFavorite event,
    Emitter<HouseListState> emit,
  ) async {
    final result = await favoriteHousesLogic.addFavorite(event.houseModel);
    result.fold((failure) {
      emit(Error(message: failure.toString()));
    }, (house) {
      if (!favoriteHouses.contains(house)) favoriteHouses.add(house);
      emit(FavoriteAdded(house: house));
    });
  }

  void _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<HouseListState> emit,
  ) async {
    final result = await favoriteHousesLogic.removeFavorite(event.houseModel);
    result.fold((failure) {
      emit(Error(message: failure.toString()));
    }, (house) {
      if (!favoriteHouses.contains(house)) favoriteHouses.remove(house);
      emit(FavoriteRemoved(house: house));
    });
  }

  void _onGetFavorites(
    GetFavorites event,
    Emitter<HouseListState> emit,
  ) async {
    if (favoriteHouses.isNotEmpty) {
      emit(FavoritesRetrieved(houses: favoriteHouses));
    } else {
      final result = await favoriteHousesLogic.getAllFavorites();
      result.fold((failure) {
        emit(Error(message: failure.toString()));
      }, (houses) {
        emit(FavoritesRetrieved(houses: houses));
      });
    }
  }
}
