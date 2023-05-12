import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

String _rssURLVNExpress = "https://vnexpress.net/rss/tin-moi-nhat.rss";

void main() async {
  final res = await http.get(Uri.parse(_rssURLVNExpress));
  if (res.statusCode == 200){
    // check res
    // print(res.body);
    // 2 JSon
    final xml2Json = Xml2Json();
    xml2Json.parse(utf8.decode(res.bodyBytes));
    String rssJson = xml2Json.toParker(); // mô hình parker
    // print(rssJson);
    //
    Map<String, dynamic> jsonData = jsonDecode(rssJson);
    // check
    var testData = jsonData["rss"]["channel"]["item"][0];
    // print(testData);

    //
    // print(testData["title"]);
    // print(testData["description"]);
    // print(testData["pubDate"]);
    // print(testData["guid"]);
    // print(testData["slash"]);

  }
}