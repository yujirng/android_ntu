import 'dart:math';

void checkDuplicate (List li) {
  List duplicate = [];
  li.forEach((e) {
    if (duplicate.contains(e)) print(e);
    else duplicate.add(e);
  });
}

void main() {
  List test = [1,2,3,4,5,6,1,2,3,4];
  checkDuplicate(test);
}