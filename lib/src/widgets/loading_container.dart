import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  renderPlaceholderBox() {
    return Container(
      color: Colors.grey,
      width: 120,
      height: 15,
    );
  }

  build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: renderPlaceholderBox(),
          subtitle: renderPlaceholderBox(),
        ),
        Divider(height: 2, color: Colors.grey)
      ],
    );
  }
}
