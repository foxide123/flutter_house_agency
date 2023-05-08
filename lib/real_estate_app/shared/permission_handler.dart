import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import 'failures.dart';

class PermissionHandler {
  final Location _location;

  PermissionHandler({
    Location? location,
  }) : _location = location ?? Location();

  Future<bool> hasLocationPermission() async {
    final permissionStatus = await _location.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<Either<Failure, bool>> requestLocationPermission() async {
    try {
      final permissionStatus = await _location.requestPermission();
      return Right(permissionStatus == PermissionStatus.granted);
    } on Exception {
      return Future.value(Left(RequestPermissionFailure()));
    }
  }
}

class RequestPermissionFailure extends Failure {
  final String message;

  RequestPermissionFailure(
      {this.message = "There was a failure when requesting permission"});

  @override
  List<Object?> get props => [message];
}
