import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/shared/distance_calculator.dart';
import 'package:flutter_assignment_project/shared/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  late DistanceCalculator distanceCalulator;

  setUp((){
    distanceCalulator = DistanceCalculator();
  });

   test('Calculate distance between location coordinates', () async{

      final lat1 = 40.7128;
      final lon1 = -74.0060;

      final lat2 = 40.730619;
      final lon2 = -73.935242;

      // When
      final Either<Failure, double> result = await distanceCalulator.calculateDistance(lat1, lon1, lat2, lon2);

      result.fold(
        (failure)=>expect(failure, isInstanceOf<DistanceCalcFailure>()),
        (distance) {
          print(distance);
          expect(distance, isNotNull);
          expect(distance, greaterThanOrEqualTo(0));
        }
      );
    });
  }