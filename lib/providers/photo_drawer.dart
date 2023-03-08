import 'package:flutter/material.dart';

class DrawerProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;
  void selectedIndexChange(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }
}
