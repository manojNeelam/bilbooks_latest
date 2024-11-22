part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class LoadingState extends ItemState {}

final class ErrorState extends ItemState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}

final class SuccessState extends ItemState {
  final ItemsResponseDataModel itemsResponseDataModel;
  SuccessState({required this.itemsResponseDataModel});
}

final class AddItemLoadingState extends ItemState {}

final class SuccessAddItemState extends ItemState {
  final AddItemMainResModel addItemMainResModel;
  SuccessAddItemState({required this.addItemMainResModel});
}

final class ErrorAddItemState extends ItemState {
  final String errorMessage;
  ErrorAddItemState({required this.errorMessage});
}

final class DeleteItemLoadingState extends ItemState {}

final class SuccessDeleteItemState extends ItemState {
  final DeleteItemMainResEntity deleteItemMainResEntity;
  SuccessDeleteItemState({required this.deleteItemMainResEntity});
}

final class ErrorDeleteItemState extends ItemState {
  final String errorMessage;
  ErrorDeleteItemState({required this.errorMessage});
}

final class ItemActiveLoadingState extends ItemState {}

final class ItemActiveSuccessState extends ItemState {
  final ItemActiveMainResEntity resEntity;
  ItemActiveSuccessState({required this.resEntity});
}

final class ItemActiveErrorState extends ItemState {
  final String errorMessage;
  ItemActiveErrorState({required this.errorMessage});
}

final class ItemInActiveLoadingState extends ItemState {}

final class ItemInActiveSuccessState extends ItemState {
  final ItemInActiveMainResEntity resEntity;
  ItemInActiveSuccessState({required this.resEntity});
}

final class ItemInActiveErrorState extends ItemState {
  final String errorMessage;
  ItemInActiveErrorState({required this.errorMessage});
}
