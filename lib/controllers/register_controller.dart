import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/controllers/auth_controller.dart';
import 'package:starter_kit_app/data/repositories/auth_repository.dart';
import 'package:starter_kit_app/utils/exceptions/server_exception.dart';
import 'package:starter_kit_app/widgets/loading/loading.dart';

class RegisterController extends GetxController {
  RegisterController(this._authRepository);
  final AuthRepository _authRepository;
  static RegisterController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final password = false.obs;
  final passwordConfirm = false.obs;

  // @override
  // void onClose() {
  //   emailController?.dispose();
  //   passwordController?.dispose();
  //   passwordConfirmController?.dispose();
  //   fullNameController?.dispose();
  //   phoneController?.dispose();
  //   super.onClose();
  // }

  void showPassword() => password.value = !password.value;
  void showPasswordConfirm() => passwordConfirm.value = !passwordConfirm.value;

  void signUpNormal() async {
    showLoadingIndicator();
    try {
      print(emailController.text.trim());
      print(passwordController.text);

      final data = {
        'name': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'password': passwordController.text,
        'password_confirmation': passwordConfirmController.text
      };

      final response = await _authRepository.signUpNormal(data: data);
      Get.snackbar('Success', 'Register Success',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.black54,
          colorText: Get.theme.snackBarTheme.actionTextColor,
          margin: EdgeInsets.all(10.0));

      if (response != null) {
        AuthController.to.saveToken(response.token);
        Get.offAllNamed(Routers.home);
      }
    } on ServerException catch (e) {
      print(e);
      Get.snackbar('error', '${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.black54,
          colorText: Get.theme.snackBarTheme.actionTextColor,
          margin: EdgeInsets.all(10.0));
    }
    hideLoadingIndicator();
  }

  Future<void> signUnGoogle() async {
    await AuthController.to.signInGoogle();
  }
}
