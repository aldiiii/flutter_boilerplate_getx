import 'package:starter_kit_app/controllers/register_controller.dart';
import 'package:starter_kit_app/data/repositories/auth_repository.dart';
import 'package:starter_kit_app/utils/services/http_client.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<HttpClient>()));

    Get.lazyPut<RegisterController>(
      () => RegisterController(Get.find<AuthRepository>()),
    );
  }
}
