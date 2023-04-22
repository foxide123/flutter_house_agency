import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/shared/distance_calculator.dart';
import 'package:flutter_assignment_project/shared/permission_handler.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/user_location_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic_interfaces/i_distance_to_house_logic.dart';
import 'package:location/location.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';

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
    final hasPermission = await permissionHandler.hasLocationPermission();
    if (!hasPermission) {
      final requestPermission =
          await permissionHandler.requestLocationPermission();
      if (requestPermission.isLeft()) return Left(RequestPermissionFailure());
    }

    final currentLocation = await userLocationLogic.getCurrentLocation();
    if (currentLocation.isLeft()) return Left(GetCurrentLocationFailure());

    final LocationData locationData =
        currentLocation.getOrElse(() => LocationData.fromMap({}));

    return distanceCalculator.calculateDistance(
        lat1, lon1, locationData.latitude, locationData.longitude);
  }


}
