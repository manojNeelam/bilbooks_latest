part of 'client_bloc.dart';

@immutable
sealed class ClientEvent {}

final class GetList extends ClientEvent {
  final ClientListParams clientListParams;
  GetList({required this.clientListParams});
}

final class DeleteClientEvent extends ClientEvent {
  final DeleteClientParams deleteClientParams;
  DeleteClientEvent({required this.deleteClientParams});
}

final class UpdateClientStatusEvent extends ClientEvent {
  final UpdateClientStatusParams params;
  UpdateClientStatusEvent({required this.params});
}

final class GetClientDetailsEvent extends ClientEvent {
  final ClientDetailsReqParams clientDetailsReqParams;
  GetClientDetailsEvent({required this.clientDetailsReqParams});
}

final class AddClientEvent extends ClientEvent {
  final AddClientUsecaseReqParams addClientUsecaseReqParams;
  AddClientEvent({required this.addClientUsecaseReqParams});
}
