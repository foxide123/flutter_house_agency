import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/sort_houses_logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/mock_house_model.dart';

void main(){

  late SortHousesLogic sortHousesLogic; 

  setUp((){
    sortHousesLogic = SortHousesLogic();
  });

  group('sort houses by price', (){
     test(
    'should sort house list by price in ascending order',
      () async{
        final result = await sortHousesLogic.sortByPrice(tMockHouseList, ascending: true);

        expect(IterableEquality().equals(result.getOrElse(() => []), tMockHouseListOrderedAsc), true);
      }
    );

    test(
    'should sort house list by price in descedning order',
      () async{
        final result = await sortHousesLogic.sortByPrice(tMockHouseList, ascending: false);

        expect(IterableEquality().equals(result.getOrElse(() => []), tMockHouseListOrderedDesc), true);
      }
    );

  });
}