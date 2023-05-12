import 'package:android_ntu/baitap/btb2/hh_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  int? posImage;

  InfoPage(this.posImage);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int imagePos = 0;
  String imageName = "";

  @override
  void initState() {
    super.initState();
    imagePos = (widget.posImage) != null ? widget.posImage! : 0;
    imageName = (widget.posImage) != null ? names[widget.posImage!] : names[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu Hoa Hậu"),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     child: Column(
      //       children: [
      //         CarouselSlider.builder(
      //             options: CarouselOptions(
      //               height: 500,
      //               enlargeCenterPage: true,
      //               autoPlay: true,
      //               initialPage: widget.posImage!,
      //               onPageChanged: (index, reason) {
      //                 setState(() {
      //                   imagePos = index;
      //                   imageName = names[index];
      //                 });
      //               },
      //             ),
      //             itemCount: images.length,
      //             itemBuilder: (context, index, realIndex) => Container(
      //                   child: Image.network(
      //                     images[index],
      //                     fit: BoxFit.contain,
      //                   ),
      //                 )),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Text("${imagePos + 1}/${images.length}",
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             SizedBox(
      //               width: 15,
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 30),
      //         Text(imageName,
      //             style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
      //         SizedBox(height: 20),
      //       ],
      //     ),
      //   ),
      // ),

      body: SizedBox.expand(
        child: CarouselSlider.builder(
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: double.infinity,
              autoPlay: true,
              initialPage: widget.posImage!,
              onPageChanged: (index, reason) {
                setState(() {
                  imagePos = index;
                  imageName = names[index];
                });
              },
              viewportFraction: 1.0,
            ),
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) => Container(
              child: Image.network(images[index]
                // ,fit: BoxFit.contain,
                ,fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
