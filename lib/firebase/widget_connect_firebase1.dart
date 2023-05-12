import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyFirebaseConnect extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext? context) builder;

  const MyFirebaseConnect(
      {Key? key,
      required this.builder,
      required this.errorMessage,
      required this.connectingMessage})
      : super(key: key);

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if (loi) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            widget.errorMessage!,
            style: TextStyle(
              fontSize: 18,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    } else if (!ketNoi) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(widget.connectingMessage!,
              style: TextStyle(fontSize: 18), textDirection: TextDirection.ltr),
        ),
      );
    } else {
      return widget.builder!(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    } catch (e) {
      setState(() {
        loi = true;
      });
    }
  }
}
