import 'package:billbooks_app/features/clients/domain/entities/add_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/delete_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/update_status_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/add_client_usecase.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/client_details_entity.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientListUseCase _clientListUseCase;
  final DeleteClientUseCase _deleteClientUseCase;
  final UpdateClientStatusUseCase _updateClientStatusUseCase;
  final ClientDetailsUseCase _clientDetailsUseCase;
  final AddClientUsecase _addClientUsecase;

  ClientBloc({
    required ClientListUseCase clientListUseCase,
    required DeleteClientUseCase deleteClientUseCase,
    required UpdateClientStatusUseCase updateClientStatusUseCase,
    required ClientDetailsUseCase clientDetailsUseCase,
    required AddClientUsecase addClientUsecase,
  })  : _clientListUseCase = clientListUseCase,
        _deleteClientUseCase = deleteClientUseCase,
        _updateClientStatusUseCase = updateClientStatusUseCase,
        _clientDetailsUseCase = clientDetailsUseCase,
        _addClientUsecase = addClientUsecase,
        super(ClientInitial()) {
    on<GetList>((event, emit) async {
      emit(ClientLoading());
      final response = await _clientListUseCase.call(event.clientListParams);
      debugPrint(response.toString());
      debugPrint("ClientListUseCase success $response");
      response.fold((l) => emit(ClientError(errorMessage: l.message)),
          (r) => emit(ClientSuccess(clientResDataEntity: r.data)));
    });

    on<DeleteClientEvent>((event, emit) async {
      emit(DeleteClientLoadingState());
      final response =
          await _deleteClientUseCase.call(event.deleteClientParams);
      response.fold(
          (l) => emit(DeleteClientErrorState(errorMessage: l.message)),
          (r) => emit(DeleteClientSuccessState(deleteClientMainResEntity: r)));
    });

    on<UpdateClientStatusEvent>((event, emit) async {
      emit(UpdateClientLoadingState());
      final response = await _updateClientStatusUseCase.call(event.params);
      response.fold(
          (l) => emit(UpdateClientErrorState(errorMessage: l.message)),
          (r) => emit(UpdateClientSuccessState(updateClientMainResEntity: r)));
    });

    on<GetClientDetailsEvent>((event, emit) async {
      emit(ClientDetailsLoadingState());
      final response =
          await _clientDetailsUseCase.call(event.clientDetailsReqParams);
      response.fold(
          (l) => emit(ClientDetailsErrorState(errorMessage: l.message)),
          (r) =>
              emit(ClientDetailsSuccessState(clientDetailsMainResEntity: r)));
    });

    on<AddClientEvent>((event, emit) async {
      emit(ClientAddLoadingState());
      final response =
          await _addClientUsecase.call(event.addClientUsecaseReqParams);
      response.fold((l) => emit(ClientAddErrorState(errorMessage: l.message)),
          (r) => emit(ClientAddSuccessState(clientAddMainResEntity: r)));
    });
  }
}
