import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/shared/permission_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';

class MockLocation extends Mock implements Location{}

void main(){
  late PermissionHandler permissionHandler;
  late MockLocation mockLocation;

  setUp((){
    mockLocation = MockLocation();
    permissionHandler = PermissionHandler(location: mockLocation);
  });

  test('should return true if the permission is given', () async{
    when(()=>mockLocation.hasPermission())
      .thenAnswer((_) async => PermissionStatus.granted);

    final bool hasLocationPermission= await permissionHandler.hasLocationPermission();

    verify(()=> mockLocation.hasPermission());

    expect(hasLocationPermission, isTrue);
  });

  test('should return false if the permission is denied', () async{
    when(()=>mockLocation.hasPermission())
      .thenAnswer((_) async=> PermissionStatus.denied);

    final bool hasLocationPermission= await permissionHandler.hasLocationPermission();

    verify(()=> mockLocation.hasPermission());

    expect(hasLocationPermission, isFalse); 
  });

  test('should return true if the request permission is successful', () async{
    when(()=>mockLocation.requestPermission())
      .thenAnswer((_) async => PermissionStatus.granted);

    final result = await permissionHandler.requestLocationPermission();

    verify(()=> mockLocation.requestPermission());

    result.fold(
        (failure) => null,
        (permissionBool) {
          expect(permissionBool, isTrue);
        },
      ); 
  });

  test('shoul return failure if the request permission is unsuccessful', () async{
    when(()=>mockLocation.requestPermission())
      .thenThrow(Exception());

    final result = await permissionHandler.requestLocationPermission();

    verify(()=> mockLocation.requestPermission());

    expect(result, Left(RequestPermissionFailure()));
  });
}