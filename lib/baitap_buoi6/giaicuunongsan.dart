import 'package:android_ntu/baitap_buoi6/firebase/firebase_data.dart';
import 'package:android_ntu/baitap_buoi6/infonongsan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../firebase/widget_connect_database.dart';
import 'giohang/getx_giohang.dart';
import 'package:android_ntu/baitap_buoi6/giohang/pagecart.dart';

// import './firebase/widget_connect_database.dart';

class GiaiCuuNSApp extends StatelessWidget {
  const GiaiCuuNSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => GiaiCuuNS(),
        errorMessage: "Lỗi",
        connectingMessage: "Đang kết nối...");
  }
}

class GiaiCuuNS extends StatefulWidget {
  const GiaiCuuNS({Key? key}) : super(key: key);

  @override
  State<GiaiCuuNS> createState() => _GiaiCuuNSState();
}

class _GiaiCuuNSState extends State<GiaiCuuNS> {
  BuildContext? _dialogContext;
  final NongSanController c = Get.put(NongSanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu Sản phẩm"),
        actions: [
          Obx(() => GestureDetector(
              onTap: () {
                Get.to(PageCart());
              },
              child: badges.Badge(
                showBadge: c.soLuongGioHang > 0 ? true : false,
                badgeContent: Text(
                  "${c.soLuongGioHang}",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageCart(),
                        ));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                badgeStyle:
                badges.BadgeStyle(badgeColor: Colors.lightBlueAccent),
              )
          )
          ),
        ],
      ),
      body: StreamBuilder<List<NongSanSnapshot>>(
        stream: NongSanSnapshot.dsSVTuFilebase(),
        builder: (context, snapshot) {
          // print(snapshot);
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text("Lỗi", // widget để truy xuất lên trên
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    textDirection:
                    TextDirection.ltr // không viết trong scaffold
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Đang load dữ liệu...", // widget để truy xuất lên trên
                        style: TextStyle(fontSize: 16),
                        textDirection:
                        TextDirection.ltr
                    ),
                  ]),
            );
          } else {
            var list = snapshot.data!;
            return GridView.extent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 5,
              crossAxisSpacing: 20,
              cacheExtent: 20,
              childAspectRatio: 0.8,
              children: List.generate(list.length, (index) =>
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(list[index].nongSan!.anh!),
                              fit: BoxFit.contain,
                            ),
                          ),
                          height: 200,
                        ),
                        Text(list[index].nongSan!.title!, style: TextStyle(fontSize: 25, color: Colors.blue),),
                        Text("${list[index].nongSan!.gia!}đ", style: TextStyle(fontSize: 20, color: Colors.red),),
                      ],
                    ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoNongSan(ns: list[index], index: index,)));
                  },
                  )
              ),
            );
          }
        },
      ),
    );
  }
}

