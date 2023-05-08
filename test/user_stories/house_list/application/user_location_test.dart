import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/user_location_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/domain/failures/get_current_location_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';

class MockLocation extends Mock implements Location{}

void main(){
  late MockLocation mockLocation;
  late UserLocationLogic userLocationLogic;

  setUp((){
    mockLocation = MockLocation();
    userLocationLogic = UserLocationLogic(location: mockLocation);
  });

  test('should return non-null LocationData', () async{
    when(()=>mockLocation.getLocation())
      .thenAnswer((_) async => LocationData.fromMap({
            "latitude": 40.7128,
            "longitude": -74.0060,
          }));

    final result = await userLocationLogic.getCurrentLocation();

    verify(() => mockLocation.getLocation());
    result.fold(
      (failure)=>null,
      (locationData){
        expect(locationData, isNotNull);
        expect(locationData.latitude, 40.7128);
        expect(locationData.longitude, -74.0060);
      }
    );
  });

  test('should throw an exception upon failure', () async{
    when(()=>mockLocation.getLocation())
      .thenThrow(Exception());

    final result = await userLocationLogic.getCurrentLocation();

    verify(()=> mockLocation.getLocation());
    expect(result, Left(GetCurrentLocationFailure()));
  });
}