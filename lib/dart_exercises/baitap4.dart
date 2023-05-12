/*import 'package:flutter/material.dart';*/

void main(){
  List<String> list = ["An", "Bình", "Minh", "Tuấn"];
  List<int> lengths = list.map((e) => e.length).toList();

  print(list);
  print(lengths);
  for (var e in lengths) {
    print(e*e);
  }

  List<int> pows = lengths.map((e) => e*e).toList();
  print(pows);

}