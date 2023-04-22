import 'package:dartz/dartz.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';

abstract class ISortHousesLogic{
  Future<Either<Failure, List<HouseModel>>> sortByPrice(List<HouseModel> houseList, {bool ascending=true});
}