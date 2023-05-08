import 'package:flutter/material.dart';

class SearchState with ChangeNotifier {
  TextEditingController _textController = TextEditingController();
  bool _isSearchPressed = false;

  TextEditingController get textController => _textController;
  bool get isSearchPressed => _isSearchPressed;

  void toggleSearchPressed() {
    _isSearchPressed = !_isSearchPressed;
    notifyListeners();
  }

  void clearSearch() {
    _textController.clear();
    notifyListeners();
  }
}