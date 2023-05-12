import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyFirebaseConnect extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext context)? builder;
  const MyFirebaseConnect(
      {Key? key,
      required this.builder,
      required this.errorMessage,
      required this.connectingMessage})
      : super(key: key);

  @override
//  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
  _MyFirebaseConnectState createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi = false;
  bool loi = false;

  @override
  Widget build(BuildContext context) {
    if(loi){
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(widget.errorMessage! // widget để truy xuất lên trên
          ,style: TextStyle(fontSize: 16)
          ,textDirection: TextDirection.ltr // không viết trong scaffold
          ),
        ),
      );
    } else
      if (!ketNoi) { // chưa kết nối
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(widget.connectingMessage! // widget để truy xuất lên trên
                  ,style: TextStyle(fontSize: 16)
                  ,textDirection: TextDirection.ltr // không viết trong scaffold
              ),
            ]
          ),
        );
      } else {
        return
            widget.builder!(context);
      }
  }


  @override
  void initState() {
    super.initState();
    _khoiTaoFireBase();
  } // hạn chế sử dụng await


  _khoiTaoFireBase() {
    Firebase.initializeApp().then((value) {
      setState(() {
        ketNoi = true;
      });
    }).catchError((error) {
      setState(() {
        loi = true;
      });
      print(error.toString());
    }).whenComplete(() => print("Kết thúc hoàn thành/hay lỗi")); // finally
  }
}
