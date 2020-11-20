import 'package:starter_kit_app/controllers/auth_controller.dart';
import 'package:starter_kit_app/data/repositories/auth_repository.dart';
import 'package:starter_kit_app/utils/services/http_client.dart';
import 'package:starter_kit_app/utils/services/local_storage.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorage>(() => LocalStorageImpl());
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<HttpClient>()));

    Get.lazyPut<AuthController>(
      () =>
          AuthController(Get.find<LocalStorage>(), Get.find<AuthRepository>()),
    );
  }
}
