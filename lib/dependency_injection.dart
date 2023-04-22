import 'package:flutter_assignment_project/shared/distance_calculator.dart';
import 'package:flutter_assignment_project/shared/json_mapper.dart';
import 'package:flutter_assignment_project/shared/permission_handler.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/data_interfaces/i_favorite_repository.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/data_interfaces/i_houses_repository.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/favorite_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/distance_to_house_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/get_all_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/get_specific_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/sort_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/user_location_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/data/favorite_repository_impl.dart';
import 'package:flutter_assignment_project/user_stories/house_list/data/houses_repository_impl.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/bloc/bloc/house_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //BLOC
  sl.registerFactory(() => HouseListBloc(
        getAllHousesLogic: sl(),
        getSpecificHousesLogic: sl(),
        getDistanceToHouseLogic: sl(),
        sortHousesLogic: sl(),
        favoriteHousesLogic: sl(),
      ));

  //logic implementations
  sl.registerLazySingleton(() => GetAllHousesLogic(sl()));
  sl.registerLazySingleton(() => GetSpecificHousesLogic(sl()));
  sl.registerLazySingleton(() => UserLocationLogic(location: sl()));
  sl.registerLazySingleton(() => SortHousesLogic());
  sl.registerLazySingleton(
    () => DistanceToHouseLogic(
      location: sl(),
      permissionHandler: sl(),
      userLocationLogic: sl(),
      distanceCalculator: sl(),
    ),
  );

  sl.registerLazySingleton(() => FavoriteHousesLogic(sl()));

  //repository
  sl.registerLazySingleton<IHousesRepository>(
      () => HousesRepositoryImpl(client: sl()));
  
  sl.registerLazySingleton<IFavoriteRepository>(
    () => FavoriteRepositoryImpl(sharedPreferences: sl()));

  //shared
  sl.registerLazySingleton(() => DistanceCalculator());
  sl.registerLazySingleton(() => PermissionHandler());
  sl.registerLazySingleton(() => JSONMapper());

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => sharedPreferences);
}
