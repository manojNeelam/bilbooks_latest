part of 'client_bloc.dart';

sealed class ClientState {}

final class ClientInitial extends ClientState {}

final class ClientLoading extends ClientState {}

final class ClientError extends ClientState {
  final String errorMessage;
  ClientError({required this.errorMessage});
}

final class ClientSuccess extends ClientState {
  ClientResDataEntity? clientResDataEntity; //1st
  ClientSuccess({required this.clientResDataEntity});
}

final class DeleteClientLoadingState extends ClientState {}

final class DeleteClientErrorState extends ClientState {
  final String errorMessage;
  DeleteClientErrorState({required this.errorMessage});
}

final class DeleteClientSuccessState extends ClientState {
  final DeleteClientMainResEntity deleteClientMainResEntity;
  DeleteClientSuccessState({required this.deleteClientMainResEntity});
}

final class UpdateClientLoadingState extends ClientState {}

final class UpdateClientErrorState extends ClientState {
  final String errorMessage;
  UpdateClientErrorState({required this.errorMessage});
}

final class UpdateClientSuccessState extends ClientState {
  final UpdateClientMainResEntity updateClientMainResEntity;
  UpdateClientSuccessState({required this.updateClientMainResEntity});
}

final class ClientDetailsLoadingState extends ClientState {}

final class ClientDetailsErrorState extends ClientState {
  final String errorMessage;
  ClientDetailsErrorState({required this.errorMessage});
}

final class ClientDetailsSuccessState extends ClientState {
  final ClientDetailsMainResEntity clientDetailsMainResEntity;
  ClientDetailsSuccessState({required this.clientDetailsMainResEntity});
}

final class ClientAddLoadingState extends ClientState {}

final class ClientAddErrorState extends ClientState {
  final String errorMessage;
  ClientAddErrorState({required this.errorMessage});
}

final class ClientAddSuccessState extends ClientState {
  final ClientAddMainResEntity clientAddMainResEntity;
  ClientAddSuccessState({required this.clientAddMainResEntity});
}
