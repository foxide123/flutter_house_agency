import 'package:dartz/dartz.dart';

import '../../domain/models/house_model.dart';
import '../../shared/failures.dart';

abstract class IGetAllHousesLogic{
  Future<Either<Failure, List<HouseModel>>> getAllHouses();
}