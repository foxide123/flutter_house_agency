import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/distance_to_house_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/favorite_houses_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/get_all_houses_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/get_specific_houses_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/application/logic/sort_houses_logic.dart';
import 'package:flutter_assignment_project/real_estate_app/bloc/bloc/house_list_bloc.dart';
import 'package:flutter_assignment_project/real_estate_app/domain/dtos/house_search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/mock_house_model.dart';

class MockGetAllHouses extends Mock implements GetAllHousesLogic {}

class MockGetSpecificHouses extends Mock implements GetSpecificHousesLogic {}

class MockDistanceToHouse extends Mock implements DistanceToHouseLogic {}

class MockSortHouses extends Mock implements SortHousesLogic {}

class MockFavoriteHouses extends Mock implements FavoriteHousesLogic{}

void main() {
  late HouseListBloc bloc;
  late MockGetAllHouses mockGetAllHouses;
  late MockGetSpecificHouses mockGetSpecificHouses;
  late MockDistanceToHouse mockDistanceToHouse;
  late MockSortHouses mockSortHouses;
  late MockFavoriteHouses mockFavoriteHouses;

  setUp(() {
    mockGetAllHouses = MockGetAllHouses();
    mockGetSpecificHouses = MockGetSpecificHouses();
    mockDistanceToHouse = MockDistanceToHouse();
    mockSortHouses = MockSortHouses();
    mockFavoriteHouses = MockFavoriteHouses();

    bloc = HouseListBloc(
      getAllHousesLogic: mockGetAllHouses,
      getSpecificHousesLogic: mockGetSpecificHouses,
      getDistanceToHouseLogic: mockDistanceToHouse,
      sortHousesLogic: mockSortHouses,
      favoriteHousesLogic: mockFavoriteHouses,
    );
  });

  group('get all houses',() {
    test('should call getAllHouses method', () async{
      when(()=>mockGetAllHouses.getAllHouses())
        .thenAnswer((_) async => Right(tMockHouseList));

      bloc.add(GetAllHouses());
      await untilCalled(()=>mockGetAllHouses.getAllHouses());

      verify(()=>mockGetAllHouses.getAllHouses());
    });
  });

  group('get specific houses', (){

    /*Params are fake and the result will not be based on params since
    we are only testing if the method was called same for other 'should call' methods*/
    HouseSearchParams searchParams = HouseSearchParams(zip:'1234', city:'Amsterdam');
    test('should call getSpecificHouses method', () async{
      when(()=>mockGetSpecificHouses.getSpecificHouses(searchParams))
        .thenAnswer((_) async => Right(tMockHouseList));

      bloc.add(GetSpecificHouses(houseSearchParams: searchParams));
      await untilCalled(()=>mockGetSpecificHouses.getSpecificHouses(searchParams));

      verify(()=>mockGetSpecificHouses.getSpecificHouses(searchParams));
      });
    });
/*
  group('get distance to house', (){
    double lat1 = 40.050;
    double lon1 = 20.125;
    test('should call getDistanceToHouse method', () async{
      when(()=>mockDistanceToHouse.getDistanceToHouse(lat1, lon1))
        .thenAnswer((_) async => Right(1234));

      bloc.add(GetDistanceToHouse(lat: lat1, lon: lon1, houseId: 0));
      await untilCalled(()=>mockDistanceToHouse.getDistanceToHouse(lat1, lon1));

      verify(()=>mockDistanceToHouse.getDistanceToHouse(lat1, lon1));
    });
  });
*/

  group('sort list of houses', (){
    test('should call sortByPrice method', () async{
      when(()=>mockSortHouses.sortByPrice(tMockHouseList, ascending: true))
        .thenAnswer((_) async => Right(tMockHouseList));

      bloc.add(SortHouses(listOfHouses: tMockHouseList, ascending: true));
      await untilCalled(()=>mockSortHouses.sortByPrice(tMockHouseList, ascending: true));

      verify(()=>mockSortHouses.sortByPrice(tMockHouseList, ascending: true));
    });
  });
}
