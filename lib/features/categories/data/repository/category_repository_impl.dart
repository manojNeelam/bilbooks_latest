import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/categories/data/datasource/remote/category_remote_datasource.dart';

import 'package:billbooks_app/features/categories/domain/entities/category_main_res_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  CategoryRepositoryImpl({required this.categoryRemoteDatasource});
  @override
  Future<Either<Failure, CategoryListMainResEntity>> getCategories() async {
    try {
      final resmodel = await categoryRemoteDatasource.getCategories();
      return right(resmodel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
