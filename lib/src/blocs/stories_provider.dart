import 'package:GriderApiFetching/src/blocs/stories_bloc.dart';
import 'package:flutter/material.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()).bloc;
  }
}
