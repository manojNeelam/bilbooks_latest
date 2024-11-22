part of 'item_bloc.dart';

@immutable
sealed class ItemEvent {}

final class GetItemList extends ItemEvent {
  final ItemListReqModel reqParams;
  GetItemList({required this.reqParams});
}

final class AddItemEvent extends ItemEvent {
  final AddIemReqModel addIemReqModel;
  AddItemEvent({required this.addIemReqModel});
}

final class DeleteItemEvent extends ItemEvent {
  final DeleteItemReqModel deleteItemReqModel;
  DeleteItemEvent({required this.deleteItemReqModel});
}

final class ItemMarkActiveEvent extends ItemEvent {
  final ItemMarkActiveUseCaseReqParams reqParams;
  ItemMarkActiveEvent({required this.reqParams});
}

final class ItemMarkInActiveEvent extends ItemEvent {
  final ItemMarkInActiveUseCaseReqParams reqParams;
  ItemMarkInActiveEvent({required this.reqParams});
}
