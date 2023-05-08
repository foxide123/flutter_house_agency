import 'package:flutter/material.dart';

class FavoriteHouses with ChangeNotifier {
  List<int> _favoriteHouseIds = [];

  List<int> get favoriteHouseIds => _favoriteHouseIds;

  void addFavoriteHouse(int houseId) {
    _favoriteHouseIds.add(houseId);
    notifyListeners();
  }

  void removeFavoriteHouse(int houseId) {
    _favoriteHouseIds.remove(houseId);
    notifyListeners();
  }

  bool isFavorite(int houseId) {
    return _favoriteHouseIds.contains(houseId);
  }
}