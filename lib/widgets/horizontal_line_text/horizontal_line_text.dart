import 'package:flutter/material.dart';

class HorizontalLineText extends StatelessWidget {
  const HorizontalLineText({this.text, this.color});

  final Text text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: Divider(color: color)),
        Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: text,
        )),
        Expanded(child: Divider(color: color)),
      ],
    );
  }
}
