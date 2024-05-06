import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void changeVal(int val) {
    count = val;
    notifyListeners();
  }
}
