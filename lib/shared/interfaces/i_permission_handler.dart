import 'package:dartz/dartz.dart';

import '../failures.dart';

abstract class IPermissionHandler{
  Future<bool> hasLocationPermission();
  Future<Either<Failure, bool>> requestLocationPermission();
}