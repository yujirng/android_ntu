import 'package:android_ntu/catalog_provider/provider_catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class AppCatalogN5 extends StatelessWidget {
  const AppCatalogN5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CatalogN5(),
      lazy: true, //khi nào dùng mới tạo ra đối tượng
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PageCatalogN5(),
      ),
    );
  }
}

class PageCatalogN5 extends StatelessWidget {
  const PageCatalogN5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cửa hàng"),
        actions: [
          Consumer<CatalogN5>(
              builder: (context, catalog, child) => badges.Badge(
                    //showBadge: điều kiện để hiển thị badges
                    //badgeContent: hiển thị số trên badges -> Widget hiển thị badges
                    //child: là giỏ hàng, là icon mà badges hiển thị vào đấy
                    //position: vị trí của badges

                    showBadge: catalog.soLuongGioHang > 0 ? true : false,
                    badgeContent: Text(
                      "${catalog.soLuongGioHang}",
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
                  )),
        ],
      ),
      body: Consumer<CatalogN5>(
        builder: (context, catalog, child) => Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    leading: Text("${index}", style: TextStyle(fontSize: 23)),
                    title: Text("${catalog.matHangs[index + 1].tenMH}",
                        style: TextStyle(fontSize: 23)),
                    trailing: catalog.kiemTraMHTonTaiTrongGH(index)
                        ? Icon(Icons.check)
                        : IconButton(
                            onPressed: () {
                              catalog.themVaoGioHang(index);
                            },
                            icon: Icon(Icons.add),
                          ),
                    subtitle: Text("${catalog.matHangs[index + 1].gia}"),
                  ),
              separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                  ),
              itemCount: catalog.soLuongMatHang-1),
        ),
      ),
    );
  }
}

class PageCart extends StatelessWidget {
  const PageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: Consumer<CatalogN5>(
        builder: (context, catalog, child) => Column(children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      leading: Text("${index}", style: TextStyle(fontSize: 23)),
                      title: Text(
                          "${catalog.matHangs[catalog.gioHang[index]].tenMH}",
                          style: TextStyle(fontSize: 23)),
                      trailing: IconButton(
                        onPressed: () {
                          catalog.xoaKhoiGioHang(index);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      subtitle: Text("${catalog.matHangs[index + 1].gia}"),
                    ),
                separatorBuilder: (context, index) => Divider(
                      thickness: 2,
                    ),
                itemCount: catalog.soLuongGioHang-1),
          ),
          Container(
            color: Colors.lightBlue,
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Tổng tiền: ${catalog.tienThanhToan}",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(width: 20)
                  ]
            ),
          ),
        ]),
      ),
    );
  }
}
