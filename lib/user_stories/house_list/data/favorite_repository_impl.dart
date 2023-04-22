import 'dart:convert';

import 'package:flutter_assignment_project/shared/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/data_interfaces/i_favorite_repository.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/models/house_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/json_mapper.dart';

class FavoriteRepositoryImpl implements IFavoriteRepository {
  late final SharedPreferences sharedPreferences;

  FavoriteRepositoryImpl({
    required this.sharedPreferences
  });

  @override
  Future<void> addFavorite(HouseModel houseToAdd) {
    return sharedPreferences.setString("house: ${houseToAdd.id}", JSONMapper.toJson(houseToAdd));
  }

  @override
  Future<Either<Failure, List<HouseModel>>> getAllFavorites() async{
    try{
      final spKeys = sharedPreferences.getKeys().where((key)=>key.startsWith('house:')).toList();
    final favorites = spKeys.map((key){
      final jsonString = sharedPreferences.getString(key);
      return JSONMapper.fromJson(jsonDecode(jsonString!));
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