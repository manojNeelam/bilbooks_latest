import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/item/data/datasource/remote/item_remote_datasource.dart';
import 'package:billbooks_app/features/item/data/models/add_item_data_model.dart';
import 'package:billbooks_app/features/item/data/models/delete_item_data_model.dart';

import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/item/domain/entities/item_active_entity.dart';
import 'package:billbooks_app/features/item/domain/entities/item_inactive_entity.dart';
import 'package:billbooks_app/features/item/domain/usecase/item_usecase.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/repository/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDatasource itemRemoteDatasource;

  ItemRepositoryImpl({required this.itemRemoteDatasource});
  @override
  Future<Either<Failure, ItemsResponseDataModel>> getItemList(
      ItemListReqModel reqParams) async {
    try {
      final resDataModel = await itemRemoteDatasource.getList(reqParams);
      return right(resDataModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddItemMainResModel>> addItem(
      AddIemReqModel addItemReqModel) async {
    Map<String, String> map = {
      "type": addItemReqModel.type ?? "",
      "name": addItemReqModel.name ?? "",
      "description": addItemReqModel.description ?? "",
      "rate": addItemReqModel.rate ?? "",
      "unit": addItemReqModel.unit ?? "",
      "sku": addItemReqModel.sku ?? "",
      "track_inventory": addItemReqModel.trackInventory ?? "",
      "stock": addItemReqModel.stock ?? "",
      "taxes": addItemReqModel.taxes ?? "",
    };
    if (addItemReqModel.id != null && addItemReqModel.id!.isNotEmpty) {
      map.addAll({
        "id": addItemReqModel.id ?? "",
      });
    }

    final formData = FormData.fromMap(map);
    try {
      final resModel = await itemRemoteDatasource.addItem(formData);
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteItemMainResDataModel>> deleteItem(
      DeleteItemReqModel reqModel) async {
    try {
      final resModel = await itemRemoteDatasource.deleteItem(reqModel);
      if (resModel.data?.success == true) {
        return right(resModel);
      } else {
        return left(Failure(resModel.data?.message ?? "Request Failed"));
      }
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemActiveMainResEntity>> itemMarkAsActive(
      ItemMarkActiveUseCaseReqParams reqModel) async {
    try {
      final resModel = await itemRemoteDatasource.itemMarkAsActive(reqModel);
      if (resModel.data?.success == true) {
        return right(resModel);
      } else {
        return left(Failure(resModel.data?.message ?? "Request Failed"));
      }
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemInActiveMainResEntity>> itemMarkAsInActive(
      ItemMarkInActiveUseCaseReqParams reqModel) async {
    try {
      final resModel = await itemRemoteDatasource.itemMarkAsInActive(reqModel);
      if (resModel.data?.success == true) {
        return right(resModel);
      } else {
        return left(Failure(resModel.data?.message ?? "Request Failed"));
      }
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
