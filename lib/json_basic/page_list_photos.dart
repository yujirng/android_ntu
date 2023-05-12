import 'package:android_ntu/json_basic/json_data.dart';
import 'package:flutter/material.dart';

class PageListPhoto extends StatelessWidget {
  const PageListPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page JSON List Photo"
        ),
      ),
      // sử dụng widget bất đồng bộ
      body: FutureBuilder<List<Photo>?>( // phải chỉ định kiểu
        future: getHTTPContent(),
        builder: (context, snapshot) { // snapshot luôn luôn trả về một bản AsyncSnapshot
          if(snapshot.hasError){
            return Center(child: Text("Không tải được Album"),);
          }
          else if(snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator(),);
          }
          else {
            //! không null
            List<Photo> listPhoto = snapshot.data!;
            return GridView.extent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 5,
              crossAxisSpacing: 20,
              cacheExtent: 20,
              childAspectRatio: 0.8, // khoảng trống text phía dưới
              // children: [
              //
              //   ListView.builder(
              //     itemCount: listPhoto.length,
              //     itemBuilder: (context, index) {
              //       return Container(child: Image.network(listPhoto[index].url!));
              //     },
              //   )
              // ],
              children: List.generate(listPhoto.length, (index) => 
                Column(
                  children: [
                    Image.network(listPhoto[index].url!),
                    Text(listPhoto[index].title!, style: TextStyle(fontSize: 8),)
                  ],
                )
              ),
            );
          }
        },
      ),
    );
  }
}
