import 'package:android_ntu/baitap/btb3/getx_catalog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:badges/badges.dart' as badges;

class AppCatalogN5GetX extends StatelessWidget {
  const AppCatalogN5GetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageCatalogN5(),
    );
  }
}

class PageCatalogN5 extends StatelessWidget {
  const PageCatalogN5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CatalogN5 c = Get.put(CatalogN5());

    return Scaffold(
      appBar: AppBar(title: Text("Cửa hàng"), actions: [
        //   GetX<CatalogN5>(
        //       builder: (catalog) => badges.Badge(
        //             showBadge: c.soLuongGioHang > 0 ? true : false,
        //             badgeContent: Text(
        //               "${c.soLuongGioHang}",
        //               style: TextStyle(color: Colors.white, fontSize: 15),
        //             ),
        //             child: IconButton(
        //               onPressed: () {
        //                 Get.to(() => PageCart());
        //               },
        //               icon: Icon(
        //                 Icons.shopping_cart,
        //                 size: 30,
        //               ),
        //             ),
        //             position: badges.BadgePosition.topEnd(top: 0, end: 3),
        //             badgeStyle:
        //                 badges.BadgeStyle(badgeColor: Colors.lightBlueAccent),
        //           )),
        // ],

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
              )]
      ),
      body: GetX<CatalogN5>(
        builder: (catalog) => Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    leading: Text("${index}", style: TextStyle(fontSize: 23)),
                    title: Text("${c.matHangs[index + 1].tenMH}",
                        style: TextStyle(fontSize: 23)),
                    trailing: Obx(
                      () => c.kiemTraMHTonTaiTrongGH(index)
                          ? Icon(Icons.check)
                          : IconButton(
                              onPressed: () {
                                c.themVaoGioHang(index);
                              },
                              icon: Icon(Icons.add),
                            ),
                    ),
                    subtitle: Text("${c.matHangs[index + 1].gia}"),
                  ),
              separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                  ),
              itemCount: c.soLuongMatHang - 1),
        ),
      ),
    );
  }
}

class PageCart extends StatelessWidget {
  const PageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CatalogN5 c = Get.put(CatalogN5());

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: GetX<CatalogN5>(
        builder: (catalog) => Column(children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      leading: Text("${index}", style: TextStyle(fontSize: 23)),
                      title: Text("${c.matHangs[c.gioHang[index]].tenMH}",
                          style: TextStyle(fontSize: 23)),
                      trailing: IconButton(
                        onPressed: () {
                          c.xoaKhoiGioHang(index);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      subtitle: Text("${c.matHangs[index + 1].gia}"),
                    ),
                separatorBuilder: (context, index) => Divider(
                      thickness: 2,
                    ),
                itemCount: c.soLuongGioHang),
          ),
          Container(
            color: Colors.lightBlue,
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "Tổng tiền: ${c.tienThanhToan}",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(width: 20)
            ]),
          ),
        ]),
      ),
    );
  }
}
