import 'package:dartz/dartz.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';

abstract class IGetAllHousesLogic{
  Future<Either<Failure, List<HouseModel>>> getAllHouses();
}