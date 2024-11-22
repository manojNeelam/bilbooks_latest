// To parse this JSON data, do
//
//     final categoryListMainResModel = categoryListMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/categories/domain/entities/category_main_res_entity.dart';

CategoryListMainResModel categoryListMainResModelFromJson(String str) =>
    CategoryListMainResModel.fromJson(json.decode(str));

class CategoryListMainResModel extends CategoryListMainResEntity {
  CategoryListMainResModel({int? success, CategoryListDataModel? data})
      : super(success: success, data: data);

  factory CategoryListMainResModel.fromJson(Map<String, dynamic> json) =>
      CategoryListMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : CategoryListDataModel.fromJson(json["data"]),
      );
}

class CategoryListDataModel extends CategoryListDataEntity {
  CategoryListDataModel({
    bool? success,
    List<CategoryModel>? categories,
    String? message,
  }) : super(success: success, categories: categories, message: message);

  factory CategoryListDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryListDataModel(
        success: json["success"],
        categories: json["categories"] == null
            ? []
            : List<CategoryModel>.from(
                json["categories"]!.map((x) => CategoryModel.fromJson(x))),
        message: json["message"],
      );
}

class CategoryModel extends CategoryEntity {
  CategoryModel({
    String? id,
    String? name,
  }) : super(id: id, name: name);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
      );
}
