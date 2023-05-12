import 'dart:math';

// Future<int> lateNumAsync() async {
//   const one = Duration(seconds: 1);
//   int num = await Future.delayed(one, () => Random().nextInt(1000)
//   );
//   return num;
// }

// void getLateNumThen() async{
//   var order = await lateNumAsync();
//   print(order);
// }

Future<int> lateNum() {
  const one = Duration(seconds: 1);
  return Future.delayed(one).then(
      (value) => Random().nextInt(1000),
  );
}

void main(){
  final test2 = lateNum();
  test2.then((value) {
    if (value % 2 == 0) {
      print("So chan: $value");
    } else print("So le: $value");
  });

  // getLateNumThen();
}