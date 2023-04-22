import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic_interfaces/i_get_all_houses_logic.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';
import '../data_interfaces/i_houses_repository.dart';

class GetAllHousesLogic implements IGetAllHousesLogic{
  final IHousesRepository repository;

  GetAllHousesLogic(this.repository);

  @override
  Future<Either<Failure, List<HouseModel>>> getAllHouses() async{
    final listOfHouses = await repository.getAllHouses();

    return listOfHouses.fold(
      (failure){
        return Left(FetchingFailure());
      },
      (houseList){
        return Right(houseList);
      }
    );
  }
}

class FetchingFailure extends Failure {
  final String message;

  FetchingFailure(
      {this.message = "There was a failure when geting specific houses"});

  @override
  List<Object?> get props => [message];
}