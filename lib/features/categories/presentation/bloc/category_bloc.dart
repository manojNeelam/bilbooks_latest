import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/categories/domain/entities/category_main_res_entity.dart';
import 'package:billbooks_app/features/categories/domain/usecase/category_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryListUsecase _usecase;

  CategoryBloc({required CategoryListUsecase usecase})
      : _usecase = usecase,
        super(CategoryInitial()) {
    on<GetCatgeories>((event, emit) async {
      emit(CategoryListLoadingState());
      final response = await _usecase.call(event.params);
      response.fold(
          (l) => emit(CategoryListErrorState(errorMessage: l.message)),
          (r) => emit(CategoryListSuccessState(categoryListMainResEntity: r)));
    });
  }
}
