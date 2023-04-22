import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic_interfaces/i_user_location_logic.dart';
import 'package:location/location.dart';

import '../../../../shared/failures.dart';

class UserLocationLogic implements IUserLocationLogic{
  final Location location;

  UserLocationLogic({
    required this.location,
  });

  @override
  Future<Either<Failure, LocationData>> getCurrentLocation() async{
    try {
      final LocationData locationData = await location.getLocation();
      return Right(locationData);
    } on Exception {
      return Future.value(Left(GetCurrentLocationFailure()));
    }
  }
}

class GetCurrentLocationFailure extends Failure {
  final String message;

  GetCurrentLocationFailure(
      {this.message = "There was a failure when requesting permission"});

  @override
  List<Object?> get props => [message];
}