import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../../domain/failures/get_current_location_failure.dart';
import '../../shared/failures.dart';
import '../logic_interfaces/i_user_location_logic.dart';

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