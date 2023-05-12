import 'package:android_ntu/baitap/bt6/carousel_slider.dart';
import 'package:android_ntu/baitap/btb2/info_page.dart';
import 'package:flutter/material.dart';
import 'hh_model.dart';

class btvnGridView extends StatelessWidget {
  const btvnGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Gridview Extends")),
      body: GridView.extent(
          // tự động chia theo chiều ngang dọc
          maxCrossAxisExtent:
              150, // đảm bảo hình không quá lớn hoặc quá nhỏ, không vượt quá
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          cacheExtent: 20, //
          children: List.generate(
              images.length,
              (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoPage(index)));
                    },
                    child: Container(
                      child: Image.network(images[index]),
                    ),
                  ))

          // images.map(
          //     (e) => GestureDetector(
          //       onTap: () {
          //
          //       },
          //       child: Container(
          //         child: Image.asset(e),
          //       ),
          //     ))
          //     .toList(),
          ),
    );
  }
}
