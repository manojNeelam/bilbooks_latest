import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/categories/domain/entities/category_main_res_entity.dart';
import 'package:billbooks_app/features/categories/domain/repository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryListUsecase
    implements UseCase<CategoryListMainResEntity, CategoryListReqParams> {
  final CategoryRepository categoryRepository;
  CategoryListUsecase({required this.categoryRepository});
  @override
  Future<Either<Failure, CategoryListMainResEntity>> call(
      CategoryListReqParams params) {
    return categoryRepository.getCategories();
  }
}

class CategoryListReqParams {}
