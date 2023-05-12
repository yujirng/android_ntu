import 'dart:math';

void main() {
  List<int> intList = [], list2 = [];

  var i = 0;
  while (i < 10) {
    var intValue = Random().nextInt(100);
    intList.add(intValue);
    i++;
  }

  list2.add(intList.first);
  list2.add(intList.last);

  print(intList);
  print(list2);
}