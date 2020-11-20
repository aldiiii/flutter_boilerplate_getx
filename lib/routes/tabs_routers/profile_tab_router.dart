import 'package:starter_kit_app/routes/bindings/auth_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/screen/home/profile_screen.dart';

class ProfileTabRouter extends StatelessWidget {
  static const navigatorIndex = 5000;

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
          page: () => ProfileScreen(),
          binding: AuthBinding());
    }

    //     if (settings.name == Routers.profileDetail) {
    //   return GetPageRoute(
    //     settings: settings,
    //     page: () => ProfileDetailPage(),
    //   );
    // }

    throw Exception('terjadi kesalahan');
  }
}
