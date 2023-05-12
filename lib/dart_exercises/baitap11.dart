import 'dart:async';

class MyStream<T>{
  StreamController<T> _streamController = StreamController();
  Stream<T> get stream => _streamController.stream;
  void addEvent(T event){
    _streamController.sink.add(event);
  }
  void dispose(){
    _streamController.close();
  }
}

void main(){
  var myStream = MyStream<String>();
  var sum = 0;
  // StreamSubscription<String> subscriber = myStream.stream.listen((
  //     event){
  //   print("Please, your $event is done!");
  // });
  // myStream.addEvent("Hamburger");

  var myStream2 = MyStream<int>();
  StreamSubscription<int> summ = myStream2.stream.listen((
      event){
    sum += event;
    print(sum);
  });

  for (var i = 0; i < 10; i++) {
    myStream2.addEvent(i);
  }
}