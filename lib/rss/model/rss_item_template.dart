// pattern tách description
Map<String, String> descriptionMap = {
  "vnexpress_start": "</a></br>",
  "vnexpress_end": "",
  "vnexpress_start": "</a></br>",
  "vnexpress_end": "",
};

String startPatternImage = 'img src="';
String endPatternImage = '"';

class RSSItem {
  String rssResourceName;
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  RSSItem.resourceNameOnly({
    required this.rssResourceName,
  });

  String get startPatternDescription => descriptionMap[rssResourceName + "_start"] as String;
  String get endPatternDescription => descriptionMap[rssResourceName + "_end"] as String;


  String _getDescription(String rawDescription) {
    var start = rawDescription.indexOf(startPatternDescription) + startPatternDescription.length;
    // -1 + length = false
    if (start >= startPatternDescription.length){
      if (endPatternDescription.length > 0){
        // tìm bắt đầu từ điểm start
        int end = rawDescription.indexOf(endPatternDescription, start);
        return rawDescription.substring(start, end);
      }
      return rawDescription.substring(start);
    }
    return "";
  }

  String? _getImageUrl(String rawImageUrl) {
    var start = rawImageUrl.indexOf(startPatternImage) + startPatternImage.length;
    // -1 + length = false
    if (start >= startPatternImage.length){
      if (endPatternImage.length > 0){
        // tìm bắt đầu từ điểm start
        int end = rawImageUrl.indexOf(endPatternImage, start);
        return rawImageUrl.substring(start, end);
      }
      return rawImageUrl.substring(start);
    }
    return null;
  }

  RSSItem getFromJson(Map<String, dynamic> json) {
    title = json['title'];
    pubDate = json['pubDate'];
    description = _getDescription(json['description']);
    link = json['link'];
    imageUrl = _getImageUrl(json['description']);
    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'pubDate': this.pubDate,
      'description': this.description,
      'link': this.link,
      'imageUrl': this.imageUrl,
    };
  }
}

