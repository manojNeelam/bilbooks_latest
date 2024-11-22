part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryListLoadingState extends CategoryState {}

final class CategoryListErrorState extends CategoryState {
  final String errorMessage;
  CategoryListErrorState({required this.errorMessage});
}

final class CategoryListSuccessState extends CategoryState {
  final CategoryListMainResEntity categoryListMainResEntity;
  CategoryListSuccessState({required this.categoryListMainResEntity});
}
