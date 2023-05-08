import 'dart:convert';
import 'dart:io';
import 'package:flutter_assignment_project/real_estate_app/domain/models/house_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/mock_house_model.dart';

void main() {
  group('fromJsonList', () {
    test(
      'should return proper models from JSON list',
      () async {
        final List<dynamic> jsonList = json.decode(
          File('test/fixtures/response.json').readAsStringSync(),
        );

        final result = HouseModel.fromJsonList(jsonList);

        expect(result, [
          tMockHouseModel,
          tMockHouseModel2
        ]); // assuming you have defined tMockHouseModel2
      },
    );
  });

  group('fromJson', () {
    String jsonString = '''{
       "id": 2,
    "image": "/uploads/house1.jpg",
    "price": 285000,
    "bedrooms": 5,
    "bathrooms": 3,
    "size": 275,
    "description": "Description",
    "zip": "1034 ZH",
    "city": "Amsterdam",
    "latitude": 52,
    "longitude": 5,
    "createdDate": "2020-05-07"
    }''';

    test(
      'should return proper model from JSON string',
      () async {
        final result = HouseModel.fromJson(jsonDecode(jsonString));

        expect(result, 
          tMockHouseModel); // assuming you have defined tMockHouseModel2
      },
    );
  });

  group('toJson', () {
    String jsonString = '''{"id":2,"image":"/uploads/house1.jpg","price":285000,"bedrooms":5,"bathrooms":3,"size":275,"description":"Description","zip":"1034 ZH","city":"Amsterdam","latitude":52,"longitude":5,"createdDate":"2020-05-07"}''';
    test(
      'should return JSON string from HouseModel', ()async{
        final result = HouseModel.toJson(tMockHouseModel);
        expect(result, jsonString);
      }
    );
  });
}
