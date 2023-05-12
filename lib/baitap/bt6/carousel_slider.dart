import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderPage extends StatefulWidget {

  int? posImage;

  CarouselSliderPage({super.key});

  @override
  State<CarouselSliderPage> createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  List<String> images = [
    'assets/rams/ram1.jpg',
    'assets/rams/ram2.jpg',
    'assets/rams/ram3.jpg',
    'assets/rams/ram4.jpg',
  ];
  int imagePos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu SP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 300,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        imagePos = index;
                      });
                    },
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) => Container(
                    child: Image.asset(images[index]),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${imagePos+1}/${images.length}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(width: 15,),
                ],
              ),
              SizedBox(height: 30),
              Text("RAM Laptop Kingmax 8GB DDR4 2400 - Hàng chính hãng",style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("850.000 đ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 23)),
                  SizedBox(width: 30),
                  Text("125.000 đ", style: TextStyle(color: Colors.grey, fontSize: 18, decoration: TextDecoration.lineThrough),)
                ],
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("4.8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(width: 10,),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star_half, color: Colors.orange),
                    SizedBox(width: 30),
                    TextButton(onPressed: () {
                      
                    }, child: Text("(Xem 100 đánh giá)", style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 20),))
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
