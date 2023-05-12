import 'package:android_ntu/rss/model/rss_item_template.dart';
import 'package:android_ntu/rss/model/rss_url.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:get/get.dart';

String resourceName = "vnexpress";

class ControllerRss extends GetxController {
  final _rssList = <RSSItem>[].obs;
  final _title = "".obs;
  List<RSSItem> get rssList => _rssList.value;
  String get title => _title.value;

  void setTitle(String name){
    _title.value = name;
    _title.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    readRss(rssURL[0].link!);
    _title.value = rssURL[0].title!;
  }

  Future<void> readRss(String url) async {
    _fetchRSS(url).then((value) {
      _rssList.value = value
              ?.map((rssMap) =>
                  RSSItem.resourceNameOnly(rssResourceName: resourceName)
                      .getFromJson(rssMap))
              .toList() ??
          [];
      _rssList.refresh();
    }).catchError((error) {
      print(error);
    });
  }

  Future<List<dynamic?>> _fetchRSS(String rssURL) async {
    final res = await http.get(Uri.parse(rssURL));
    if (res.statusCode == 200) {
      final xml2Json = Xml2Json();
      xml2Json.parse(utf8.decode(res.bodyBytes));
      String rssJson = xml2Json.toParker();
      Map<String, dynamic> jsonData = jsonDecode(rssJson);
      return (jsonData["rss"]["channel"]["item"]);
    }
    return Future.error("Lỗi đọc RSS");
  }
}
