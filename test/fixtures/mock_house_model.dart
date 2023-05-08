import 'package:flutter_assignment_project/real_estate_app/domain/models/house_model.dart';

final tMockHouseModel = HouseModel(
      bedrooms: 5,
      bathrooms: 3,
      city: 'Amsterdam',
      createdDate: '2020-05-07',
      description: 'Description',
      id: 2,
      image: '/uploads/house1.jpg',
      latitude: 52,
      longitude: 5,
      price: 285000,
      size: 275,
      zip: '1034 ZH'
      );

final tMockHouseModel2 = HouseModel(
    bedrooms: 3,
      bathrooms: 1,
      city: 'Amsterdam',
      createdDate: '2020-05-07',
      description: 'Description 2',
      id: 3,
      image: '/uploads/house2.jpg',
      latitude: 52,
      longitude: 5,
      price: 969000,
      size: 153,
      zip: '1016 BV'
);

final tMockHouseList = <HouseModel>[tMockHouseModel2, tMockHouseModel];
final tMockHouseListOrderedAsc = <HouseModel>[tMockHouseModel, tMockHouseModel2];
final tMockHouseListOrderedDesc = <HouseModel>[tMockHouseModel2, tMockHouseModel];