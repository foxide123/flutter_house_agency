import 'dart:convert';

import 'package:equatable/equatable.dart';

class HouseModel extends Equatable{
  final int id;
  final String image;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int size;
  final String description;
  final String zip;
  final String city;
  final int latitude;
  final int longitude;
  final String createdDate;

  HouseModel({
    required this.id,
    required this.image,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.createdDate
  });

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
  
  @override
  List<Object?> get props => [id, image, price, bedrooms, bathrooms, size, description, zip, city, latitude, longitude, createdDate];
}