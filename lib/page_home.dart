// Bài tập

import 'package:android_ntu/baitap/bt6/carousel_slider.dart';
import 'package:android_ntu/baitap/bt6/my_grid_view_extends.dart';
import 'package:android_ntu/baitap/bt6/my_list_view.dart';
import 'package:android_ntu/baitap/btb2/btvn_gridview.dart';
import 'package:android_ntu/baitap/btb3/catalog_app.dart';
import 'package:android_ntu/baitap_buoi6/giaicuunongsan.dart';
import 'package:android_ntu/baitap_buoi6/login.dart';

//
import 'package:android_ntu/catalog_provider/catalog_app.dart';
import 'package:android_ntu/firebase/authentication/page_login.dart';
import 'package:android_ntu/firebase/cloud_firestore/page_firebase_app.dart';
import 'package:android_ntu/firebase/testapp/page_test_firebase.dart';
import 'package:android_ntu/form/page_form_mathang.dart';
import 'package:android_ntu/getX/GetXLearningPage.dart';
import 'package:android_ntu/json_basic/page_list_photos.dart';
import 'package:android_ntu/main.dart';
import 'package:android_ntu/ntu/page_counter.dart';
import 'package:android_ntu/profile/page_profile.dart';
import 'package:android_ntu/firebase/cloud_firestore/page_firebase_app.dart';

import 'package:android_ntu/sqflite/page_sqlite_app.dart';
import 'package:android_ntu/url_launcher/test.dart';
import 'package:flutter/material.dart';

//Rss
import 'package:android_ntu/rss/pages/page_rss.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildButton(context, title: 'Profile', destination: PageMyProfile()),
                buildButton(context, title: 'Carousel', destination: CarouselSliderPage()),
                buildButton(context, title: 'Grid View', destination: GridviewExtends()),
                buildButton(context, title: 'Grid Carousel', destination: btvnGridView()),
                buildButton(context, title: 'List View', destination: MyListView()),
                buildButton(context, title: 'Form Page', destination: PageFormMatHang()),
                buildButton(context, title: 'Counter', destination: CounterApp()),
                buildButton(context, title: 'CounterGetX', destination: GetXLearningPage()),
                buildButton(context, title: 'CatalogProvider', destination: AppCatalogN5()),
                buildButton(context, title: 'CatalogGetX', destination: AppCatalogN5GetX()),
                buildButton(context, title: 'JSON\nPhoto List', destination: PageListPhoto()),
                buildButton(context, title: 'SQFLite', destination: SQLiteApp()),
                buildButton(context, title: 'MyFirebaseApp', destination: MyFirebaseApp()),
                buildButton(context, title: 'Test Url_launcher', destination: MyAppUrlLauncher()),
                buildButton(context, title: 'Page Login', destination: LoginApp()),
                buildButton(context, title: 'Page RSS', destination: PageRss()),
                // buildButton(context, title: 'Giai Cuu NS', destination: GiaiCuuNSApp()),
                buildButton(context, title: 'Giai Cuu NS', destination: LoginNSApp()),
              ],
            ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, {required String title, required Widget destination}) {
    return Container(
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => destination,
                      )
                  );
                },
                child: Text(title,
                style: TextStyle(fontSize: 20),)
            ),
          );
  }
}
