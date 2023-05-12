import 'package:android_ntu/baitap_buoi6/firebase/firebase_data.dart';
import 'package:android_ntu/baitap_buoi6/giohang/getx_giohang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import 'package:android_ntu/baitap_buoi6/giohang/pagecart.dart';

class InfoNongSan extends StatefulWidget {
  final NongSanSnapshot ns;
  final index;
  const InfoNongSan({required this.ns, required this.index, Key? key}) : super(key: key);

  @override
  State<InfoNongSan> createState() => _InfoNongSanState();
}

class _InfoNongSanState extends State<InfoNongSan> {
  @override
  Widget build(BuildContext context) {

    final NongSanController nongSanController = Get.put(NongSanController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu Sản phẩm"),
          actions: [
            Obx(() => GestureDetector(
                onTap: () {
                  Get.to(PageCart());
                },
                child: badges.Badge(
                  showBadge: nongSanController.soLuongGioHang > 0 ? true : false,
                  badgeContent: Text(
                    "${nongSanController.soLuongGioHang}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
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
            )


            ]
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.ns.nongSan!.anh!),
                          fit: BoxFit.contain,
                        ),
                      ),
                      height: 400,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "${widget.ns.nongSan!.title}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${widget.ns.nongSan!.gia} đ",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 23)),
                        SizedBox(width: 30),
                        Text(
                          "${widget.ns.nongSan!.gia_goc}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${widget.ns.nongSan!.sao}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star_half, color: Colors.orange),
                        SizedBox(width: 30),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "(Xem 100 đánh giá)",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  nongSanController.themVaoGioHang(widget.index);
                },
                child: Ink(
                  color: Colors.lightBlue,
                  child: Container(
                    height: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Thêm vào giỏ hàng",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(width: 20)
                        ]),
                  ),
                ),
              ),
            ]),
          ),

      ),
    );
  }
}
