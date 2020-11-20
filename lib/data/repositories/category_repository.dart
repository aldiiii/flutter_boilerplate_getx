import 'package:starter_kit_app/constants/urls.dart';
import 'package:starter_kit_app/data/models/category_model.dart';
import 'package:starter_kit_app/utils/services/http_client.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> fetchCategory();
}

class CategoryRepositoryImpl extends CategoryRepository {
  final HttpClient _client;

  CategoryRepositoryImpl(this._client);

  @override
  Future<List<CategoryModel>> fetchCategory() async {
    await Future.delayed(Duration(seconds: 1));

    final response = await _client.get(URLs.menuCategory);

    // return List<CategoryModel>.fromJson(response['data']);
    return (response['data'] as List)
        .map<CategoryModel>((json) => CategoryModel.fromJson(json))
        .toList();
  }
}
