import 'package:flutter/material.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int currentIndex = 0;
  void updateIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    notifyListeners();
  }
}
