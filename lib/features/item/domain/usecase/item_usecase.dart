import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/item/data/models/add_item_data_model.dart';
import 'package:billbooks_app/features/item/data/models/delete_item_data_model.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/item/domain/entities/item_active_entity.dart';
import 'package:billbooks_app/features/item/domain/repository/item_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/item_inactive_entity.dart';

class ItemUsecase implements UseCase<ItemsResponseDataModel, ItemListReqModel> {
  final ItemRepository itemRepository;
  ItemUsecase({required this.itemRepository});

  @override
  Future<Either<Failure, ItemsResponseDataModel>> call(
      ItemListReqModel params) async {
    return await itemRepository.getItemList(params);
  }
}

class AddItemUseCase implements UseCase<AddItemMainResModel, AddIemReqModel> {
  final ItemRepository itemRepository;
  AddItemUseCase({required this.itemRepository});

  @override
  Future<Either<Failure, AddItemMainResModel>> call(AddIemReqModel params) {
    return itemRepository.addItem(params);
  }
}

class ItemListReqModel {
  String query;
  String columnName;
  String status;
  String orderBy;
  String page;

  ItemListReqModel({
    required this.query,
    required this.columnName,
    required this.status,
    required this.orderBy,
    required this.page,
  });
}

class AddIemReqModel {
  String? id;
  String? type;
  String? name, sku, description, rate, unit, trackInventory, stock;
  String? taxes;
  AddIemReqModel(
      {this.id,
      this.type,
      this.name,
      this.sku,
      this.description,
      this.rate,
      this.unit,
      this.trackInventory,
      this.stock,
      this.taxes});
}

class DeleteItemUseCase
    implements UseCase<DeleteItemMainResDataModel, DeleteItemReqModel> {
  final ItemRepository itemRepository;
  DeleteItemUseCase({required this.itemRepository});

  @override
  Future<Either<Failure, DeleteItemMainResDataModel>> call(
      DeleteItemReqModel params) {
    return itemRepository.deleteItem(params);
  }
}

class DeleteItemReqModel {
  final String id;
  DeleteItemReqModel({required this.id});
}

class ItemMarkActiveUseCase
    implements
        UseCase<ItemActiveMainResEntity, ItemMarkActiveUseCaseReqParams> {
  final ItemRepository itemRepository;
  ItemMarkActiveUseCase({required this.itemRepository});
  @override
  Future<Either<Failure, ItemActiveMainResEntity>> call(
      ItemMarkActiveUseCaseReqParams params) {
    return itemRepository.itemMarkAsActive(params);
  }
}

class ItemMarkActiveUseCaseReqParams {
  final String id;
  ItemMarkActiveUseCaseReqParams({required this.id});
}

class ItemMarkInActiveUseCase
    implements
        UseCase<ItemInActiveMainResEntity, ItemMarkInActiveUseCaseReqParams> {
  final ItemRepository itemRepository;
  ItemMarkInActiveUseCase({required this.itemRepository});
  @override
  Future<Either<Failure, ItemInActiveMainResEntity>> call(
      ItemMarkInActiveUseCaseReqParams params) {
    return itemRepository.itemMarkAsInActive(params);
  }
}

class ItemMarkInActiveUseCaseReqParams {
  final String id;
  ItemMarkInActiveUseCaseReqParams({required this.id});
}
