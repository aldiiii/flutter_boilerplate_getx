import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/routes/bindings/home_binding.dart';
import 'package:starter_kit_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/screen/home/profile_screen.dart';

class HomeTabRouter extends StatelessWidget {
  static const navigatorIndex = 1000;

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
      return GetPageRoute(
        settings: settings,
        page: () => HomeScreen(),
        binding: HomeBinding(),
      );
    }

    if (settings.name == Routers.profile) {
      return GetPageRoute(
        settings: settings,
        page: () => ProfileScreen(),
        binding: HomeBinding(),
      );
    }

    throw Exception('terjadi kesalahan');
  }
}
