import 'package:GriderApiFetching/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';

import 'screens/news_list.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
      title: 'NewsFlash',
      home: NewsList(),
    ));
  }
}
