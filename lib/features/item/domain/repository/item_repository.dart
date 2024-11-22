import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/item/data/models/add_item_data_model.dart';
import 'package:billbooks_app/features/item/data/models/delete_item_data_model.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/item/domain/entities/item_active_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/item_inactive_entity.dart';
import '../usecase/item_usecase.dart';

abstract interface class ItemRepository {
  Future<Either<Failure, ItemsResponseDataModel>> getItemList(
      ItemListReqModel reqParams);
  Future<Either<Failure, AddItemMainResModel>> addItem(
      AddIemReqModel addItemReqModel);
  Future<Either<Failure, DeleteItemMainResDataModel>> deleteItem(
      DeleteItemReqModel reqModel);
  Future<Either<Failure, ItemActiveMainResEntity>> itemMarkAsActive(
      ItemMarkActiveUseCaseReqParams reqModel);
  Future<Either<Failure, ItemInActiveMainResEntity>> itemMarkAsInActive(
      ItemMarkInActiveUseCaseReqParams reqModel);
}
