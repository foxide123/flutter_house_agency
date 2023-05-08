import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/real_estate_app/application/data_interfaces/i_houses_repository.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/get_specific_houses_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/domain/dtos/house_search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../../../fixtures/mock_house_model.dart';


class MockIHousesRepository extends Mock implements IHousesRepository {}

void main() {
  late GetSpecificHousesLogic usecase;
  late MockIHousesRepository mockHousesRepository;

  setUp(() {
    mockHousesRepository = MockIHousesRepository();
    usecase = GetSpecificHousesLogic(mockHousesRepository);
  });

  final tMockSearchParams = HouseSearchParams(zip: '1034 ZH', city: 'Amsterdam');
  test(
    'should get specific houses based on search params from the repository',
    () async{
      //arrange
      when(()=> mockHousesRepository.getSpecificHouses(tMockSearchParams))
      .thenAnswer((_) async => Right([tMockHouseModel]));
      //act
      final result = await usecase.getSpecificHouses(tMockSearchParams);
      //assert
    result.fold(
        (failure) => null,
        (houseList) {
          expect(IterableEquality().equals(houseList, [tMockHouseModel]), true);
        },
      );
     // expect(result, equals(Right(List<tHouseModel>)));
      verify(()=>mockHousesRepository.getSpecificHouses(tMockSearchParams));

    }
  );
}
