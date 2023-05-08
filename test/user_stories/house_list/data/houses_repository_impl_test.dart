import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/real_estate_app/data/houses_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/mock_house_model.dart';

class MockHttpClient extends Mock implements http.Client{}

void main(){
  late HousesRepositoryImpl housesRepositoryImpl;
  late MockHttpClient mockHttpClient;
  setUp((){
    mockHttpClient = MockHttpClient();
    housesRepositoryImpl = HousesRepositoryImpl(client: mockHttpClient);
  });

  setUpAll(() {
    //registerFallback
    registerFallbackValue(Uri());
  });

  final List<dynamic> jsonList = json.decode(
        File('test/fixtures/response.json').readAsStringSync(),
      );

  test('should return response 200', () async{

    when(()=>mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(json.encode(jsonList), 200));
    // act
    final result = await housesRepositoryImpl.getAllHouses();
    // assert
    result.fold(
        (failure) => null,
        (houseList) {
          expect(IterableEquality().equals(houseList, [tMockHouseModel, tMockHouseModel2]), true);
        },
      );
  },
  );

  test('should throw an exception when status code is not 200', () async{
     when(()=>mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(('Error'), 404));

      final result = await housesRepositoryImpl.getAllHouses();

      expect(result, Left(ServerFailure()));
  });
}