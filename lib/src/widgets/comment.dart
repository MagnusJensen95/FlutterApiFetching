import 'package:GriderApiFetching/src/models/item_model.dart';
import 'package:GriderApiFetching/src/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final int depth;
  final Map<int, Future<ItemModel>> cacheMap;

  Comment({this.itemId, this.cacheMap, @required this.depth});

  renderText(ItemModel item) {
    var text = item.text
        .replaceAll('&#x27;', '\'')
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');

    return text;
  }

  build(context) {
    return FutureBuilder(
        future: cacheMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          final item = snapshot.data;
          final commentsList = item.kids
              .map((kid) =>
                  Comment(itemId: kid, cacheMap: cacheMap, depth: depth + 1))
              .toList();
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(
                    right: 16,
                    left: double.parse(
                      '${depth * 16 + 16}',
                    )),
                title: Text(renderText(item)),
                subtitle:
                    Text(item.by == '' ? 'this post got deleted' : item.by),
              ),
              Divider(height: 10),
              ...commentsList,
            ],
          );
        });
  }
}
