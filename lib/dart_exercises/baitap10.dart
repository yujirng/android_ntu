import 'dart:math';

Stream<int> countStream(int count) async*{
  for(int i=0; i<=count; i++) {
    // yield i;
    yield Random().nextInt(100);
  }
}

Future<int> sumStream(Stream<int> stream) async {
  var sum=0;
  await for(var value in stream)
    sum += value;
  return sum;
}

void main() async{
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum);
}
