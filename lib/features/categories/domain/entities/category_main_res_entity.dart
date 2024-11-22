class CategoryListMainResEntity {
  int? success;
  CategoryListDataEntity? data;

  CategoryListMainResEntity({
    this.success,
    this.data,
  });
}

class CategoryListDataEntity {
  bool? success;
  List<CategoryEntity>? categories;
  String? message;

  CategoryListDataEntity({
    this.success,
    this.categories,
    this.message,
  });
}

class CategoryEntity {
  String? id;
  String? name;

  CategoryEntity({
    this.id,
    this.name,
  });
}
