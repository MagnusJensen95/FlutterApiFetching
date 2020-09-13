import 'package:GriderApiFetching/src/blocs/comments_bloc.dart';
import 'package:flutter/widgets.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc commentsBloc;

  CommentsProvider({Key key, Widget child})
      : commentsBloc = CommentsBloc(),
        super(key: key, child: child);

  updateShouldNotify(_) => true;

  static CommentsBloc of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<CommentsProvider>()
      .commentsBloc;
}
