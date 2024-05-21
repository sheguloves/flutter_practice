import 'package:flutter/material.dart';

class GlobalContext with ChangeNotifier {
  GlobalContext();

  bool showDelete = false;

  void turnOnDelete() {
    showDelete = true;
    notifyListeners();
  }

  void turnOffDelete() {
    showDelete = false;
    notifyListeners();
  }
}