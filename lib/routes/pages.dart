import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/routes/bindings/auth_binding.dart';
import 'package:starter_kit_app/routes/bindings/home_binding.dart';
import 'package:starter_kit_app/screen/auth/login_screen.dart';
import 'package:starter_kit_app/screen/auth/registerScreen.dart';
import 'package:starter_kit_app/screen/base_screen.dart';
import 'package:get/get.dart';

import 'bindings/register_binding.dart';

class Pages {
  static List<GetPage> getPages = [
    GetPage(
        name: Routers.login, page: () => LoginScreen(), binding: AuthBinding()),
    GetPage(
        name: Routers.register,
        page: () => RegisterScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: Routers.home, page: () => BaseScreen(), binding: HomeBinding())
  ];
}
