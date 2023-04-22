import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/shared/distance_calculator.dart';
import 'package:flutter_assignment_project/shared/permission_handler.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/distance_to_house_logic.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic/user_location_logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';

class MockLocation extends Mock implements Location {}

class MockPermissionHandler extends Mock implements PermissionHandler{}

class MockUserLocationLogic extends Mock implements UserLocationLogic{}

class MockDistanceCalculator extends Mock implements DistanceCalculator{}

void main() {
  late MockLocation mockLocation;
  late MockPermissionHandler mockPermissionHandler;
  late MockUserLocationLogic mockUserLocationLogic;
  late DistanceCalculator distanceCalculator;
  late DistanceToHouseLogic distanceToHouseLogic;


  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockLocation = MockLocation();
    distanceCalculator = DistanceCalculator();
    mockPermissionHandler = MockPermissionHandler();
    mockUserLocationLogic = MockUserLocationLogic();

    distanceToHouseLogic = DistanceToHouseLogic(
      location: mockLocation,
      permissionHandler: mockPermissionHandler,
      userLocationLogic: mockUserLocationLogic,
      distanceCalculator: distanceCalculator,
    );
  });

  test('should return non-negative double value', () async{
    when(()=>mockLocation.getLocation())
      .thenAnswer((_) async => LocationData.fromMap({
            "latitude": 40.7128,
            "longitude": -74.0060,
          }));
    when(()=>mockPermissionHandler.hasLocationPermission())
      .thenAnswer((_) async => true);
    when(()=>mockPermissionHandler.requestLocationPermission())
      .thenAnswer((_) async => Future.value(const Right(true)));
    when(()=>mockUserLocationLogic.getCurrentLocation())
      .thenAnswer((_)=>Future.value(Right(LocationData.fromMap({
            "latitude": 40.7128,
            "longitude": -70.0060,
          }))));
    

    final result = await distanceToHouseLogic.getDistanceToHouse(40.7128, -74.0060);

    print(result);
    result.fold(
      (failure)=>null,
      (distance){
        expect(distance, isNotNull);
        expect(distance, greaterThanOrEqualTo(0));
      }
    );
  });
}
