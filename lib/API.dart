import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://zh.eliz.club/api/stories?page=";

class API {
  static Future getItems() {
    var url = baseUrl + "0";
    return http.get(url);
  }
  static Future getStory(reference) {
    var url = "https://zh.eliz.club/api/story?url=" + reference;
    return http.get(url);
  }
}

