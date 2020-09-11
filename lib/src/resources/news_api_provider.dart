import 'dart:convert';

import 'package:GriderApiFetching/src/models/item_model.dart';
import 'package:GriderApiFetching/src/resources/repository.dart';
import 'package:http/http.dart' show Client;

final _baseUrl = 'https://hacker-news.firebaseio.com';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_baseUrl/v0/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_baseUrl/v0/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
