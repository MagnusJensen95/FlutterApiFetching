import 'package:GriderApiFetching/src/blocs/comments_bloc.dart';
import 'package:GriderApiFetching/src/blocs/comments_provider.dart';
import 'package:GriderApiFetching/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import 'screens/news_details.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    }
    return MaterialPageRoute(
      builder: (context) {
        final id = int.parse(settings.name.replaceFirst('/', ''));
        final CommentsBloc commentsBloc = CommentsProvider.of(context);
        commentsBloc.fetchItemWithComments(id);
        return NewsDetails(id: id);
      },
    );
  }

  Widget build(BuildContext context) {
    return StoriesProvider(
      child: CommentsProvider(
        child: MaterialApp(
          title: 'NewsFlash',
          onGenerateRoute: routes,
        ),
      ),
    );
  }
}
