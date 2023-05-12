import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getx_giohang.dart';

class PageCart extends StatelessWidget {
  const PageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NongSanController c = Get.put(NongSanController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: GetX<NongSanController>(
        builder: (catalog) =>
            Column(children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        ListTile(
                          leading: Text(
                              "${index}", style: TextStyle(fontSize: 23)),
                          title: Text("${c.listNongSan[c.gioHang[index]['index']!].nongSan!.title}",
                              style: TextStyle(fontSize: 23)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  c.giamSoLuong(index);
                                },
                              ),
                              Text("${c.gioHang[index]['soluong']}"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  c.tangSoLuong(index);
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  c.xoaKhoiGioHang(index);
                                },
                                icon: Icon(Icons.clear),
                              ),
                            ],
                          ),
                          subtitle: Text("${c.listNongSan[c.gioHang[index]['index']!].nongSan!.gia}"),
                        ),
                    separatorBuilder: (context, index) =>
                        Divider(
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

