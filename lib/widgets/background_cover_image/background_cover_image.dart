import 'package:flutter/material.dart';

class BackgroundCoverImage extends StatelessWidget {
  const BackgroundCoverImage({Key key, this.child, @required this.bg})
      : super(key: key);

  final Widget child;
  final String bg;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bg), fit: BoxFit.cover),
        ),
        child: child);
  }
}
