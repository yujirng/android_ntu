import 'package:android_ntu/ntu/changenotifier_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: ChangeNotifier_CounterButton(),
    );
  }
}

class ChangeNotifier_CounterButton extends StatelessWidget {
  ChangeNotifier_CounterButton({Key? key}) : super(key: key);

  int num=0;
  @override
  Widget build(BuildContext context) {

    return Consumer<Counter>(
      child: Text("Not rebuild!: ${num}", style: TextStyle(fontSize: 25)),
      builder: (context, counter, child) => Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Counter App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                num++;
                counter.tang();
              }, child: Text("Tăng")),
              Text("${counter.value}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),),
              child!,
              ElevatedButton(onPressed: () {
                num--;
                counter.giam();
              }, child: Text("Giảm"))
            ],
          ),
        ),
      ),
    ),);
  }
}

class PageCounter2 extends StatelessWidget {
  const PageCounter2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              var c = context.read<Counter>();
              c.tang();
            }, child: Text("Tăng")),
            Consumer<Counter>(builder: (context, counter, child) => Column(
              children: [
                Text("${counter.value}", style: TextStyle(fontSize: 40),),
                child ?? Text("Bị null rồi!", style: TextStyle(fontSize: 25, color: Colors.redAccent),),
              ],
            ),
              child: Text("Not Rebuild: ${context.read<Counter>()}"),
            ),
            ElevatedButton(onPressed: () {
              var c = context.read<Counter>();
              c.giam();
            }, child: Text("Giảm"))
          ],
        ),
      ),
    );
  }
}

class PageCounterNonConsumer extends StatelessWidget {
  const PageCounterNonConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var counter = Provider.of<Counter>(context, listen: true);
    // var counter = context.watch<Counter>();
    var counter = context.select<Counter, int>((value) => value.value);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              context.read<Counter>().tang();
            }, child: Text("Tăng")),
            Text("${context.read<Counter>().value}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),),
            ElevatedButton(onPressed: () {
              context.read<Counter>().giam();
            }, child: Text("Giảm"))
          ],
        ),
      ),
    );
  }
}


