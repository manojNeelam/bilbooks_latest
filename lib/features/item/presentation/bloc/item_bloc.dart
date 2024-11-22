import 'package:billbooks_app/features/item/data/models/add_item_data_model.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/item/domain/entities/delete_item_entity.dart';
import 'package:billbooks_app/features/item/domain/entities/item_active_entity.dart';
import 'package:billbooks_app/features/item/domain/usecase/item_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/item_inactive_entity.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemUsecase _itemUsecase;
  final AddItemUseCase _addItemUseCase;
  final DeleteItemUseCase _deleteItemUseCase;
  final ItemMarkActiveUseCase _itemMarkActiveUseCase;
  final ItemMarkInActiveUseCase _itemMarkInActiveUseCase;

  ItemBloc(
      {required ItemUsecase itemUsecase,
      required AddItemUseCase addItemUseCase,
      required DeleteItemUseCase deleteItemUseCase,
      required ItemMarkActiveUseCase itemMarkActiveUseCase,
      required ItemMarkInActiveUseCase itemMarkInActiveUseCase})
      : _itemUsecase = itemUsecase,
        _addItemUseCase = addItemUseCase,
        _deleteItemUseCase = deleteItemUseCase,
        _itemMarkActiveUseCase = itemMarkActiveUseCase,
        _itemMarkInActiveUseCase = itemMarkInActiveUseCase,
        super(ItemInitial()) {
    on<GetItemList>((event, emit) async {
      emit(LoadingState());
      final response = await _itemUsecase.call(event.reqParams);
      response.fold((l) => emit(ErrorState(errorMessage: l.message)),
          (r) => emit(SuccessState(itemsResponseDataModel: r)));
    });

    on<AddItemEvent>((event, emit) async {
      emit(AddItemLoadingState());
      final response = await _addItemUseCase.call(event.addIemReqModel);
      response.fold((l) => emit(ErrorAddItemState(errorMessage: l.message)),
          (r) => emit(SuccessAddItemState(addItemMainResModel: r)));
    });

    on<DeleteItemEvent>((event, emit) async {
      emit(DeleteItemLoadingState());
      final response = await _deleteItemUseCase.call(event.deleteItemReqModel);
      debugPrint("DeleteItemEvent Bloc");
      debugPrint(response.toString());
      response.fold((l) => emit(ErrorDeleteItemState(errorMessage: l.message)),
          (r) => emit(SuccessDeleteItemState(deleteItemMainResEntity: r)));
    });

    on<ItemMarkActiveEvent>((event, emit) async {
      emit(ItemActiveLoadingState());
      final response = await _itemMarkActiveUseCase.call(event.reqParams);
      debugPrint(response.toString());
      response.fold((l) => emit(ItemActiveErrorState(errorMessage: l.message)),
          (r) => emit(ItemActiveSuccessState(resEntity: r)));
    });

    on<ItemMarkInActiveEvent>((event, emit) async {
      emit(ItemInActiveLoadingState());
      final response = await _itemMarkInActiveUseCase.call(event.reqParams);
      debugPrint(response.toString());
      response.fold(
          (l) => emit(ItemInActiveErrorState(errorMessage: l.message)),
          (r) => emit(ItemInActiveSuccessState(resEntity: r)));
    });
  }
}
