import 'package:starter_kit_app/controllers/auth_controller.dart';
import 'package:starter_kit_app/controllers/language_controller.dart';
import 'package:starter_kit_app/data/repositories/auth_repository.dart';
import 'package:starter_kit_app/utils/services/http_client.dart';
import 'package:starter_kit_app/utils/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorage>(() => LocalStorageImpl());
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<HttpClient>()));

    Get.put<HttpClient>(HttpClientImpl(Dio()), permanent: true);
    // Get.put<LanguageController>(LanguageController(Get.find<LocalStorage>()),
    //     permanent: true);
    Get.lazyPut<LanguageController>(
        () => LanguageController(Get.find<LocalStorage>()));
    Get.put<AuthController>(
        AuthController(Get.find<LocalStorage>(), Get.find<AuthRepository>()),
        permanent: true);
  }
}
