import 'dart:math';

import 'package:dartz/dartz.dart';

import '../domain/failures/distance_calc_failure.dart';
import 'failures.dart';

class DistanceCalculator{
  Future<Either<Failure, double>>  calculateDistance(lat1, lon1, lat2, lon2) async{
    try{
      var p = 0.017453292519943295;
      var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
      return Future.value(Right(12742 * asin(sqrt(a))));
    }on Exception{
      return Future.value(Left(DistanceCalcFailure()));
    }
  }
}
