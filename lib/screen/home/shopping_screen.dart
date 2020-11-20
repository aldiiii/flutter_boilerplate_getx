import 'package:starter_kit_app/widgets/background_cover_image/background_cover_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return BackgroundCoverImage(
      bg: 'assets/bg/home.png',
      child: SafeArea(
        child: Container(
          width: 300,
          height: 300,
          child: Text('Shopping'),
        ),
      ),
    );
  }
}
