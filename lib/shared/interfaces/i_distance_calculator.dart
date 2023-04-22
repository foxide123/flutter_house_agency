import 'package:dartz/dartz.dart';

import '../failures.dart';

abstract class IDistanceCalculator{
  Future<Either<Failure, double>>  calculateDistance(lat1, lon1, lat2, lon2);
}