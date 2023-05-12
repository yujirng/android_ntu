import 'dart:convert';

import 'package:http/http.dart' as http;

class Photo {
  String? title, url, thumbnailUrl;
  int? albumId, id;

  Photo({
    required this.title,
    this.url,
    this.thumbnailUrl,
    this.albumId,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'url': this.url,
      'thumbnailUrl': this.thumbnailUrl,
      'albumId': this.albumId,
      'id': this.id
    };
  }

  factory Photo.fromJSON(Map<String, dynamic> map){
    return Photo(
      title: map['title'] as String,
      url: map['url'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      albumId: map['albumId'] as int,
      id: map['id'] as int,
    );
  }
}

Future <void> getHTTPContentTest() async {
  String url = "https://jsonplaceholder.typicode.com/photos";
  Uri uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  // check response == 200 -> trả về data thành công
  if (response.statusCode == 200){
    print(response.body);
  }
  else {
    print("Lỗi không lấy được dữ liệu");
  }
}

// viết bên ngoài lớp photo => toàn
Future <List<Photo>?> getHTTPContent() async {
  List<Photo>? listPhoto;
  String url = "https://jsonplaceholder.typicode.com/photos";
  Uri uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  // check response == 200 -> trả về data thành công
  if (response.statusCode == 200){
    // print(response.body);
    List<dynamic> list = jsonDecode(response.body) as List;
    // mỗi e là một đối tượng Map<String, value> với key - value, ...
    listPhoto = list.map((e) => Photo.fromJSON(e)).toList();
    return listPhoto;
  }
  else {
    print("Lỗi không lấy được dữ liệu");
    return Future.error("Error!");
  }
}