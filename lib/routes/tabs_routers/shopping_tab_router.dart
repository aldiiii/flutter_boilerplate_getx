import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/screen/home/shopping_screen.dart';

class ShoppingTabRouter extends StatelessWidget {
  static const navigatorIndex = 4000;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(navigatorIndex),
      initialRoute: '/',
      onGenerateRoute: onGenerateRouter,
    );
  }

  static Route onGenerateRouter(RouteSettings settings) {
    if (settings.name == '/') {
      return GetPageRoute(settings: settings, page: () => ShoppingScreen());
    }

    throw Exception('terjadi kesalahan');
  }
}
