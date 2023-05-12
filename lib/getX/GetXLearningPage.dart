import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  var count = 0.obs;
  increment() => count++;
}

class GetXLearningPage extends StatelessWidget {
  GetXLearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text("Click: ${c.count}"))),
      body: Center(child: ElevatedButton(
        child: Text("Go to Other"), onPressed: () => Get.to(OtherPage()),
      )),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => c.increment(),),
    );
  }
}

class OtherPage extends StatelessWidget {
  OtherPage({Key? key}) : super(key: key);

  @override
  final Controller c = Get.find();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Other Page")),
      body: Center(child: Text(" ${c.count}", style: TextStyle(fontSize: 30),)),
    );
  }
}
