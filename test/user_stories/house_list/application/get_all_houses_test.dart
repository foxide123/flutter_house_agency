import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/real_estate_app/application/data_interfaces/i_houses_repository.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/get_all_houses_logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/mock_house_model.dart';


class MockIHousesRepository extends Mock implements IHousesRepository {}

void main() {
  late GetAllHousesLogic usecase;
  late MockIHousesRepository mockIHousesRepository;

  setUp(() {
    mockIHousesRepository = MockIHousesRepository();
    usecase = GetAllHousesLogic(mockIHousesRepository);
  });

  test(
    'should get all houses from the repository',
    () async{
      //arrange
      when(()=> mockIHousesRepository.getAllHouses())
      .thenAnswer((_) async => Right([tMockHouseModel]));
      //act
      final result = await usecase.getAllHouses();
      //assert

    

    result.fold(
        (failure) => null,
        (houseList) {
          expect(IterableEquality().equals(houseList, [tMockHouseModel]), true);
        },
      );
     // expect(result, equals(Right(List<tHouseModel>)));
      verify(()=>mockIHousesRepository.getAllHouses());

    }
  );
}
