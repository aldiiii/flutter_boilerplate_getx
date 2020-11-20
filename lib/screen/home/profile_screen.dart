import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/controllers/auth_controller.dart';
import 'package:starter_kit_app/widgets/button/primary_button.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/widgets/background_cover_image/background_cover_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_kit_app/localizations.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AuthController authController = AuthController.to;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    final labels = AppLocalizations.of(context);

    return BackgroundCoverImage(
      bg: 'assets/bg/home.png',
      child: SafeArea(
        child: Center(
          child: GetBuilder<AuthController>(
            builder: (authController) {
              print('logged ' + authController.isLogged.value.toString());
              if (authController.isLogged.value == true) {
                return PrimaryButton(
                    labelText: 'Logout',
                    onPressed: () async {
                      authController.logout();
                    });
              } else {
                return PrimaryButton(
                    labelText: labels?.auth?.loginButton,
                    onPressed: () async {
                      Get.toNamed(Routers.login);
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
