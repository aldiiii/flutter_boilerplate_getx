// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  CategoryModel({
    this.id,
    this.slug,
    this.name,
    this.menus,
  });

  int id;
  dynamic slug;
  String name;
  List<MenuCategory> menus;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        menus: List<MenuCategory>.from(
            json["menus"].map((x) => MenuCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
      };
}

class MenuCategory {
  MenuCategory({
    this.id,
    this.categoryId,
    this.title,
    this.caption,
    this.image,
  });

  int id;
  int categoryId;
  String title;
  Caption caption;
  String image;

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        caption: captionValues.map[json["caption"]],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "caption": captionValues.reverse[caption],
        "image": image == null ? null : image,
      };
}

enum Caption { TEST }

final captionValues = EnumValues({"test": Caption.TEST});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
