import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../../shared/failures.dart';

abstract class IUserLocationLogic{
  Future<Either<Failure, LocationData>> getCurrentLocation();
}