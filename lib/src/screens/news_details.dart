import 'dart:ui';

import 'package:GriderApiFetching/src/blocs/comments_bloc.dart';
import 'package:GriderApiFetching/src/blocs/comments_provider.dart';
import 'package:GriderApiFetching/src/models/item_model.dart';
import 'package:GriderApiFetching/src/widgets/comment.dart';
import 'package:GriderApiFetching/src/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsDetails extends StatelessWidget {
  final int id;

  NewsDetails({this.id});

  Widget renderTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget renderList(ItemModel item, Map<int, Future<ItemModel>> cacheMap) {
    final commentsList = item.kids
        .map((kid) => Comment(itemId: kid, cacheMap: cacheMap, depth: 0))
        .toList();

    return ListView(children: [
      renderTitle(item),
      ...commentsList,
    ]);
  }

  Widget renderBody(CommentsBloc bloc) {
    return StreamBuilder<Map<int, Future<ItemModel>>>(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        } else {
          final itemFuture = snapshot.data[id];

          return FutureBuilder(
            future: itemFuture,
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              } else {
                return renderList(itemSnapshot.data, snapshot.data);
              }
            },
          );
        }
      },
    );
  }

  build(context) {
    final CommentsBloc commentsBloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Story Details'),
      ),
      body: renderBody(commentsBloc),
    );
  }
}
