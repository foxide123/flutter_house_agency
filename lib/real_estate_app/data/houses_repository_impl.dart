import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../application/data_interfaces/i_houses_repository.dart';
import '../domain/dtos/house_search_params.dart';
import '../domain/models/house_model.dart';
import '../shared/failures.dart';

class HousesRepositoryImpl implements IHousesRepository {
  late final http.Client client;

  HousesRepositoryImpl({
    required this.client
  });

  @override
  Future<Either<Failure, List<HouseModel>>> getAllHouses() async {
    final response = await client.get(
      Uri.parse('https://intern.d-tt.nl/api/house'),
      headers: {
        'Content-Type': 'application/json',
        'Access-Key': '98bww4ezuzfePCYFxJEWyszbUXc7dxRx'
      },
    );
    if (response.statusCode == 200) {
      return Right(HouseModel.fromJsonList(json.decode(response.body)));
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<HouseModel>>> getSpecificHouses(
      HouseSearchParams houseSearch) async {
    final listOfHouses = await getAllHouses();
    return listOfHouses.fold((failure) {
      return Left(ServerFailure());
    }, (houseList) {
      List<HouseModel> specificHouses = houseList.where((house) {
        bool zipMatches = houseSearch.zip == null ||
            house.zip.toLowerCase().contains(houseSearch.zip!.toLowerCase());
        bool cityMatches = houseSearch.city == null ||
            house.city.toLowerCase().contains(houseSearch.city!.toLowerCase());
        if(houseSearch.city == ""){
          return zipMatches;
        }else if(houseSearch.zip == null){
          return cityMatches;
        }else{
          return zipMatches && cityMatches;
        }
      }).toList();
      return Right(specificHouses);
    });
  }
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = "Server Exception - Status code is not 200"});

  @override
  List<Object?> get props => [message];
}

