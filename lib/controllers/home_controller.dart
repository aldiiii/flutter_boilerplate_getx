import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_kit_app/data/models/category_model.dart';
import 'package:starter_kit_app/data/repositories/category_repository.dart';
import 'package:starter_kit_app/utils/enums/app_state.dart';
import 'package:starter_kit_app/utils/exceptions/server_exception.dart';

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository;

  HomeController(this._categoryRepository);
  static HomeController to = Get.find();

  List<CategoryModel> categoryState = List<CategoryModel>();

  final appState = Rx<AppState>();

  // fetch category menus
  Future<void> fetchCategory() async {
    try {
      appState.value = AppState.LOADING;
      final List<CategoryModel> response =
          await _categoryRepository.fetchCategory();

      if (response != null) {
        categoryState = response;
        update(['menus-cetegory']);
      }

      appState.value = AppState.DONE;
    } on ServerException catch (e) {
      Get.snackbar('error', '${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.black54,
          colorText: Get.theme.snackBarTheme.actionTextColor,
          margin: EdgeInsets.all(10.0));

      appState.value = AppState.ERROR;
    }
  }
}
