import 'package:starter_kit_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/data/repositories/category_repository.dart';
import 'package:starter_kit_app/utils/services/http_client.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryRepository>(
        () => CategoryRepositoryImpl(Get.find<HttpClient>()));

    Get.put<HomeController>(HomeController(Get.find<CategoryRepository>()),
        permanent: true);
  }
}
