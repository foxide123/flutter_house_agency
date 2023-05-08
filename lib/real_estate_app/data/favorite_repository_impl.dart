import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../application/data_interfaces/i_favorite_repository.dart';
import '../domain/models/house_model.dart';
import '../shared/failures.dart';

class FavoriteRepositoryImpl implements IFavoriteRepository {
  late final SharedPreferences sharedPreferences;

  FavoriteRepositoryImpl({
    required this.sharedPreferences
  });

  @override
  Future<void> addFavorite(HouseModel houseToAdd) {
    return sharedPreferences.setString("house: ${houseToAdd.id}", HouseModel.toJson(houseToAdd));
  }

  @override
  Future<void> removeFavorite(HouseModel houseToAdd) {
    return sharedPreferences.remove("house: ${houseToAdd.id}");
  }

  @override
  Future<Either<Failure, List<HouseModel>>> getAllFavorites() async{
    try{
      final spKeys = sharedPreferences.getKeys().where((key)=>key.startsWith('house:')).toList();
    final favorites = spKeys.map((key){
      final jsonString = sharedPreferences.getString(key);
      return HouseModel.fromJson(jsonDecode(jsonString!));
    }).toList();
      return Right(favorites);
    }catch(err){
      return Left(SharedPreferencesError());
    }
  }
}

class SharedPreferencesError extends Failure {
  final String message;

  SharedPreferencesError({this.message = "Server Exception - Status code is not 200"});

  @override
  List<Object?> get props => [message];
}