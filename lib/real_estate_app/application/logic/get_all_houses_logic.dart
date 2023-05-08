import 'package:dartz/dartz.dart';

import '../../domain/failures/fetching_failure.dart';
import '../../domain/models/house_model.dart';
import '../../shared/failures.dart';
import '../data_interfaces/i_houses_repository.dart';
import '../logic_interfaces/i_get_all_houses_logic.dart';

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
