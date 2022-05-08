import 'dart:convert';

import 'package:news_app/modals/news.dart';
import 'package:http/http.dart' as http;

class GetNews {
  static Future<List<News>> getNews(String country) async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=ab6c9c5d675f4cfd940130cba3f607df'));

    List<News> news = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data['articles']) {
        News newss = News(
          item['urlToImage'],
          item['title'],
          item['description'],
          item['url'],
        );

        news.add(newss);
      }

      return news;
    } else {
      throw Exception();
    }
  }
}
