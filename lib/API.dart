import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://news.zhedge.xyz/api/stories?page=";

class API {
  static Future getItems(page) {
    var url = baseUrl + page;
    return http.get(url);
  }
  static Future getStory(reference) {
    var url = "https://news.zhedge.xyz/api/story?url=" + reference;
    return http.get(url);
  }

  static Future searchItems(search, page) {
    var url = "https://news.zhedge.xyz/api/search?srchtext=" + search + "&page=" + page;
    return http.get(url);
  }
}

