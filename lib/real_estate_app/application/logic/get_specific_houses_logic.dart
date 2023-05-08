import 'package:dartz/dartz.dart';
import '../../domain/dtos/house_search_params.dart';
import '../../shared/failures.dart';
import '../../domain/failures/fetching_failure.dart';
import '../../domain/models/house_model.dart';
import '../data_interfaces/i_houses_repository.dart';
import '../logic_interfaces/i_get_specific_houses_logic.dart';

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