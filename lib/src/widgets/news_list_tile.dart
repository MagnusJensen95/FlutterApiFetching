import 'package:GriderApiFetching/src/blocs/stories_bloc.dart';
import 'package:GriderApiFetching/src/blocs/stories_provider.dart';
import 'package:GriderApiFetching/src/models/item_model.dart';
import 'package:GriderApiFetching/src/widgets/loading_container.dart';
import 'package:flutter/material.dart';

class NewsListTile extends StatelessWidget {
  final int id;

  NewsListTile({this.id});

  renderTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
          ),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants ?? 0} comments')
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (
        context,
        AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot,
      ) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[id],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return renderTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }
}
