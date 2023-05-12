import 'package:android_ntu/baitap/bt6/my_list_view.dart';
import 'package:android_ntu/rss/controller/rss_controller.dart';
import 'package:android_ntu/rss/model/rss_url.dart';
import 'package:android_ntu/rss/pages/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageRss extends StatelessWidget {
  PageRss({Key? key}) : super(key: key);
  var controller = Get.put(ControllerRss());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text("Danh mục: " + controller.title)),
        ),
        // tự động cập nhật
        body: RefreshIndicator(
          onRefresh: () => controller.readRss(rssURL[0].title!),
          child: GetX<ControllerRss>(
            init: controller,
            builder: (controller) {
              var listRss = controller.rssList;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Get.to(MyWebPage(url: listRss[index].link!)),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: _getImage(
                                            listRss[index].imageUrl))),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: Text(
                                        listRss[index].title!,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      )),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(listRss[index].description!),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          thickness: 2,
                        ),
                    itemCount: listRss.length),
              );
            },
          ),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Danh mục: ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ...List.generate(
              rssURL.length,
              (index) => ListTile(
                onTap: () {
                  controller.readRss(rssURL[index].link!);
                  controller.setTitle(rssURL[index].title!);
                  Navigator.pop(context);
                },
                title: Text(rssURL[index].title!,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
            )
          ],
        )));
  }

  Widget _getImage(String? url) {
    if (url != null) {
      return Image.network(url, fit: BoxFit.fitWidth);
    }
    return Center(
      child: Column(
        children: [
          Icon(Icons.image),
          Text("No Image!"),
        ],
      ),
    );
  }
}
