import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic_interfaces/i_get_specific_houses_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/dtos/house_search_params.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';
import '../data_interfaces/i_houses_repository.dart';

class GetSpecificHousesLogic implements IGetSpecificHousesLogic{
  final IHousesRepository repository;

  GetSpecificHousesLogic(this.repository);

  @override
  Future<Either<Failure, List<HouseModel>>> getSpecificHouses(HouseSearchParams searchParams) async{
    final listOfHouses = await repository.getSpecificHouses(searchParams);
    
    return listOfHouses.fold(
      (failure){
        return Left(FetchingFailure());
      },
      (houseList){
        if(houseList.isEmpty) return Left(FetchingFailure());
        return Right(houseList);
      }
    );
  }
}

class FetchingFailure extends Failure {
  final String message;

  FetchingFailure(
      {this.message = "No houses found"});

  @override
  List<Object?> get props => [message];
}