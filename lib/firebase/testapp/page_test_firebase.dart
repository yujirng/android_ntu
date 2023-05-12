import 'package:android_ntu/firebase/widget_connect_firebase1.dart';
import 'package:flutter/material.dart';

class TestFireBase extends StatelessWidget {
  const TestFireBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(builder: (context) => PageTestFirebase(), errorMessage: "Lỗi kết nối!", connectingMessage: "Đang kết nối...");
  }
}

class PageTestFirebase extends StatelessWidget {
  PageTestFirebase ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Firebase App"),
      ),
    );
  }
}

