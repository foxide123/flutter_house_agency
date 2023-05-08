import 'package:dartz/dartz.dart';

import '../../domain/dtos/house_search_params.dart';
import '../../domain/models/house_model.dart';
import '../../shared/failures.dart';

abstract class IHousesRepository {
  Future<Either<Failure, List<HouseModel>>> getAllHouses();
  Future<Either<Failure, List<HouseModel>>> getSpecificHouses(HouseSearchParams houseSearch);
}