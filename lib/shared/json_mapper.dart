import 'dart:convert';

import 'package:flutter_assignment_project/user_stories/house_list/domain/models/house_model.dart';

class JSONMapper {
   static List<HouseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => HouseModel(
              id: json['id'],
              image: json['image'],
              price: json['price'],
              bedrooms: json['bedrooms'],
              bathrooms: json['bathrooms'],
              size: json['size'],
              description: json['description'],
              zip: json['zip'],
              city: json['city'],
              latitude: json['latitude'],
              longitude: json['longitude'],
              createdDate: json['createdDate'],
            ))
        .toList();
    }

    static String toJson(HouseModel house) {
    Map<String, dynamic> jsonObject = {
      'id': house.id,
      'image': house.image,
      'price': house.price,
      'bedrooms': house.bedrooms,
      'bathrooms': house.bathrooms,
      'size': house.size,
      'description': house.description,
      'zip': house.zip,
      'city': house.city,
      'latitude': house.latitude,
      'longitude': house.longitude,
      'createdDate': house.createdDate,
    };
    return jsonEncode(jsonObject);
  }

  static HouseModel fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      image: json['image'],
      price: json['price'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      size: json['size'],
      description: json['description'],
      zip: json['zip'],
      city: json['city'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdDate: json['createdDate'],
    );
  }
}



