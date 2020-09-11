import 'package:GriderApiFetching/src/blocs/stories_bloc.dart';
import 'package:GriderApiFetching/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final StoriesBloc storiesBloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await storiesBloc.clearStoriesCache();
        storiesBloc.fetchTopIds();
      },
    );
  }
}
