
import 'dart:io';

void checkArgs(dynamic a) {
  if (a is int) {
    for (int i = 1; i <= a; i++) {
      if (a % i == 0) {
        // print("${i} ");
      stdout.write("$i ");
      }
    }
  } else if (a is double){
    print(a.truncate());
  }
  else if (a is String) {
    print(a.toUpperCase());
  }
}

void main () {
  var a = 15;
  var b = 15.5;
  var c = "asd";
  checkArgs(a);
  print("");
  checkArgs(b);
  checkArgs(c);
}