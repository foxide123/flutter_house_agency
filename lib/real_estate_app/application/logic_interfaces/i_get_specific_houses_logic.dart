import 'package:dartz/dartz.dart';

import '../../shared/failures.dart';
import '../../domain/dtos/house_search_params.dart';
import '../../domain/models/house_model.dart';

abstract class IGetSpecificHousesLogic{
  Future<Either<Failure, List<HouseModel>>> getSpecificHouses(HouseSearchParams searchParams);
}