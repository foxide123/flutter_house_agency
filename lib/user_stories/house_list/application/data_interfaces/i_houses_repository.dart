import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/dtos/house_search_params.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/models/house_model.dart';

import '../../../../shared/failures.dart';

abstract class IHousesRepository {
  Future<Either<Failure, List<HouseModel>>> getAllHouses();
  Future<Either<Failure, List<HouseModel>>> getSpecificHouses(HouseSearchParams houseSearch);
}