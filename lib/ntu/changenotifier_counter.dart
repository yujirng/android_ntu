import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier{
  int _value = 0;
  int get value => _value;
  void tang() {
    _value++;
    notifyListeners(); // thông báo cho các listener
  }

  void giam(){
    _value--;
    notifyListeners();
  }
}