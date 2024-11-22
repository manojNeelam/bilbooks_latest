import 'package:billbooks_app/features/more/expenses/domain/entities/add_expenses_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/delete_expense_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/expenses_list_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/expenses_list_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/new_expenses_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpensesListUsecase _expensesListUsecase;
  final NewExpensesUsecase _newExpensesUsecase;
  final DeleteExpenseUsecase _deleteExpenseUsecase;

  ExpensesBloc(
      {required ExpensesListUsecase expensesListUsecase,
      required NewExpensesUsecase newExpensesUsecase,
      required DeleteExpenseUsecase deleteExpenseUsecase})
      : _expensesListUsecase = expensesListUsecase,
        _newExpensesUsecase = newExpensesUsecase,
        _deleteExpenseUsecase = deleteExpenseUsecase,
        super(ExpensesInitial()) {
    on<GetExpensesList>((event, emit) async {
      emit(ExpensesListLoadingState());
      final response = await _expensesListUsecase.call(event.params);
      response.fold(
          (l) => emit(ExpensesListErrorState(errorMessage: l.message)),
          (r) => emit(ExpensesListSuccessState(expensesListMainResEntity: r)));
    });

    on<AddExpensesEvent>((event, emit) async {
      emit(AddExpensesLoadingState());
      final response = await _newExpensesUsecase.call(event.params);
      response.fold((l) => emit(AddExpensesErrorState(errorMessage: l.message)),
          (r) => emit(AddExpensesSuccessState(addExpensesMainResEntity: r)));
    });

    on<DeleteExpenseEvent>((event, emit) async {
      emit(DeleteExpensesLoadingState());
      final response = await _deleteExpenseUsecase.call(event.params);
      response.fold(
          (l) => emit(DeleteExpensesErrorState(errorMessage: l.message)),
          (r) =>
              emit(DeleteExpensesSuccessState(deleteExpensesMainResEntity: r)));
    });
  }
}
