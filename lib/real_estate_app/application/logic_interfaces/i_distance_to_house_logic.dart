import 'package:dartz/dartz.dart';

import '../../shared/failures.dart';

abstract class IDistanceToHouseLogic{
  Future<Either<Failure, double>> getDistanceToHouse(double lat1, double lon1);
}