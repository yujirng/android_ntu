import 'package:android_ntu/baitap_buoi6/giaicuunongsan.dart';
import 'package:android_ntu/firebase/authentication/page_register.dart';
import 'package:android_ntu/firebase/widget_connect_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_ntu/helper/dialogs.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'giaicuunongsan.dart';

class LoginNSApp extends StatelessWidget {
  const LoginNSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageLogin(),
        errorMessage: "Lỗi",
        connectingMessage: "Đang kết nối");
  }
}

class PageLogin extends StatefulWidget {
  PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: txtEmail,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                controller: txtPassword,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StyledElevatedButton(
                icon: Icons.email_outlined,
                title: "Sign in with email",
                onPressed: () {
                  if (txtEmail.text != "" && txtPassword.text != "") {
                    signInWithEmailPassword(context,
                        email: txtEmail.text,
                        password: txtPassword.text,
                        onSigned: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => GiaiCuuNSApp())));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final String title;

  StyledElevatedButton(
      {super.key, this.onPressed, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
          onPressed: () async {
            if (onPressed != null) {
              onPressed!();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (icon != null)
                  ? Icon(icon as IconData?)
                  : SizedBox(
                width: 1,
              ),
              SizedBox(width: 10),
              Text(title)
            ],
          )),
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

void signInWithEmailPassword(BuildContext context,
    {required String email,
      required String password,
      String? registeringMessage,
      void Function()? onSigned,
      String? signinMessage,
      String? signedMessage}) async {
  try {
    showSnackBar(context, signinMessage ?? "Signing in...", 60);
    var userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential != null) {
      showSnackBar(context, signedMessage ?? "SignIn successful", 5);
      if (onSigned != null) {
        onSigned();
      }
    }
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, e.code, 5);
  } catch (e) {
    print(e);
  }
}

