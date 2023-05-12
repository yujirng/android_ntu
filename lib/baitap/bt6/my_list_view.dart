import 'dart:math';

import 'package:flutter/material.dart';

List<String> list = [
  "Táo", "Chuối", "Xoài", "Bầu", "Bí", "Nho", "Dưa leo", "Dưa hấu", "Cam", "Ớt", "Ổi", "Thanh Long", "Cam", "Cam", "Cam", "Cam", "Cam", "Cam", "Cam", "Cam"
];

class MyListView extends StatelessWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List View",)
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              leading: Text("${index+1}", style: TextStyle(fontSize: 23)),
              title: Text(list[index], style: TextStyle(fontSize: 23)),
              trailing: Text("${Random().nextInt(100)} kg", style: TextStyle( fontSize: 18)),
              subtitle: Text("Thuốc sâu, ăn chết ráng chịu!"),
            ),
            separatorBuilder: (context, index) => Divider(thickness: 2,),
            itemCount: list.length),
      ),
    );
  }
}
