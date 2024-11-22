part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class GetCatgeories extends CategoryEvent {
  final CategoryListReqParams params;
  GetCatgeories({required this.params});
}
