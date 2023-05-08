import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../../domain/failures/distance_calc_failure.dart';
import '../../domain/failures/get_current_location_failure.dart';
import '../../shared/distance_calculator.dart';
import '../../shared/failures.dart';
import '../../shared/permission_handler.dart';
import '../logic_interfaces/i_distance_to_house_logic.dart';
import 'user_location_logic.dart';

class DistanceToHouseLogic implements IDistanceToHouseLogic {
  final Location location;
  final PermissionHandler permissionHandler;
  final UserLocationLogic userLocationLogic;
  final DistanceCalculator distanceCalculator;

  DistanceToHouseLogic({
    required this.location,
    required this.permissionHandler,
    required this.userLocationLogic,
    required this.distanceCalculator,
  });

  @override
  Future<Either<Failure, double>> getDistanceToHouse(
      double lat1, double lon1) async {
    final locationResult = await getCurrentLocation();

    return locationResult.fold(
      (failure){
        return Left(RequestPermissionFailure());
      },
      (locationData)async{
        final distanceCalcResult = await distanceCalculator.calculateDistance(
        lat1, lon1, locationData.latitude, locationData.longitude);
        return distanceCalcResult.fold(
          (failure){
            return Left(DistanceCalcFailure());
          },
          (locationResult){
            return Right(locationResult);
          }
        );
      }
    );
  }



  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    final hasPermission = await permissionHandler.hasLocationPermission();
    if (!hasPermission) {
      final requestPermission =
          await permissionHandler.requestLocationPermission();
      if (requestPermission.isLeft()) return Left(RequestPermissionFailure());
    }

    final currentLocation = await userLocationLogic.getCurrentLocation();
      if (currentLocation.isLeft()) return Left(GetCurrentLocationFailure());

      return Right(currentLocation.getOrElse(() => LocationData.fromMap({})));
  }
}
