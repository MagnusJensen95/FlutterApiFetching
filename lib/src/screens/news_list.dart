import 'package:GriderApiFetching/src/blocs/stories_bloc.dart';
import 'package:GriderApiFetching/src/models/item_model.dart';
import 'package:GriderApiFetching/src/widgets/news_list_tile.dart';
import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  Widget buildList(StoriesBloc bloc) {
    bloc.fetchTopIds();
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                bloc.fetchItem(snapshot.data[index]);
                return NewsListTile(id: snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          }
        });
  }

  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(title: Text('Top News')),
      body: buildList(bloc),
    );
  }
}
