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
  
  @override
  List<Object?> get props => [id, image, price, bedrooms, bathrooms, size, description, zip, city, latitude, longitude, createdDate];
}