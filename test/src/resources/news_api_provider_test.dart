import 'package:GriderApiFetching/src/models/item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GriderApiFetching/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

main() {
  test("Check that we are getting id's", () async {
    final newsProvider = NewsApiProvider();

    newsProvider.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsProvider.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });
  test("Check that we are properly fetching an item", () async {
    final newsProvider = NewsApiProvider();

    newsProvider.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsProvider.fetchItem(1);

    expect(item.id, 123);
  });
}
