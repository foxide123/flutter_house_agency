import 'dart:convert';
import 'dart:io';

import 'package:flutter_assignment_project/shared/json_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/mock_house_model.dart';

void main(){
  final jsonMapper = JSONMapper();

 group('fromJsonList', () {
  test(
    'should return proper models from JSON list',
    () async {
      final List<dynamic> jsonList = json.decode(
        File('test/fixtures/response.json').readAsStringSync(),
      );

      final result = JSONMapper.fromJsonList(jsonList);

      expect(result, [tMockHouseModel, tMockHouseModel2]); // assuming you have defined tMockHouseModel2
    },
  );
});
}