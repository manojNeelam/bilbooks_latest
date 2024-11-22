import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/account_receivables_entity.dart';
import '../../domain/usecase/account_receivables_usecase.dart';

part 'accountrecivable_event.dart';
part 'accountrecivable_state.dart';

class AccountrecivableBloc
    extends Bloc<AccountrecivableEvent, AccountrecivableState> {
  final AccountReceivablesUsecase _accountReceivablesUsecase;
  AccountrecivableBloc({
    required AccountReceivablesUsecase accountReceivablesUsecase,
  })  : _accountReceivablesUsecase = accountReceivablesUsecase,
        super(AccountrecivableInitial()) {
    {
      on<GetAccountReceivablesEvent>((event, emit) async {
        emit(AccountReceivablesLoadingState());
        final response = await _accountReceivablesUsecase.call(event.params);
        response.fold(
            (l) => emit(AccountReceivablesErrorState(errorMessage: l.message)),
            (r) => emit(AccountReceivablesSuccessState(
                accountsReceivablesMainResEntity: r)));
      });
    }
  }
}
