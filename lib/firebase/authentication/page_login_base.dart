import 'package:android_ntu/firebase/widget_connect_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_ntu/helper/dialogs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageLogin(),
        errorMessage: "Lỗi",
        connectingMessage: "Đang kết nối");
  }
}

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  var user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: "test622@gmail.com", password: "khongnho");
                  if (user != null) {
                    showSnackBar(context, "Đã đăng ký thành công!", 3000);
                  }
                },
                child: Text("Đăng ký email")),
            ElevatedButton(
                onPressed: () async {
                  var user = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: "test622@gmail.com", password: "khongnho");
                  if (user != null) {
                    showSnackBar(context, "Đã đăng nhập thành công", 3000);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PageHome(),
                    ));
                  }
                },
                child: Text("Đăng nhập email")),
            ElevatedButton(
                onPressed: () async {
                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication? googleAuth =
                      await googleUser?.authentication;
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  var user = await FirebaseAuth.instance
                      .signInWithCredential(credential);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PageHome(),
                    ));
                  }
                },
                child: Text("Đăng nhập với google"))
          ],
        ),
      ),
    );
  }
}

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Home"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("${FirebaseAuth.instance.currentUser?.toString()}"),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => PageLogin(),
                      ),
                      (route) => false);
                },
                child: Text("Sign out"))
          ],
        ),
      ),
    );
  }
}
