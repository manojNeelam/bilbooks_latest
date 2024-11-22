import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/categories/domain/entities/category_main_res_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CategoryRepository {
  Future<Either<Failure, CategoryListMainResEntity>> getCategories();
}
