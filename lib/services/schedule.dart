import 'package:flutter/material.dart';

class Schedule with ChangeNotifier {
  //state values
  var _minusVal = 0.0;

  double get getMinusVal => _minusVal;

  set minusVal(double newValue) {
    _minusVal = newValue;
    notifyListeners();
  }
}
