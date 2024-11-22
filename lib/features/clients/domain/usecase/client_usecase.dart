import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_details_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/delete_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/update_status_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/client_repository.dart';

class ClientListUseCase
    implements UseCase<ClientResponseEntity, ClientListParams> {
  final ClientRepository clientRepository;
  ClientListUseCase(this.clientRepository);
  @override
  Future<Either<Failure, ClientResponseEntity>> call(
      ClientListParams params) async {
    return await clientRepository.getList(params);
  }
}

class ClientListParams {
  final String query;
  final String status;
  final String columnName;
  final String sortOrder;
  final String page;
  ClientListParams({
    required this.query,
    required this.status,
    required this.columnName,
    required this.sortOrder,
    required this.page,
  });
}

class DeleteClientUseCase
    implements UseCase<DeleteClientMainResEntity, DeleteClientParams> {
  final ClientRepository clientRepository;
  DeleteClientUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, DeleteClientMainResEntity>> call(
      DeleteClientParams params) async {
    return await clientRepository.deleteClient(params);
  }
}

class DeleteClientParams {
  String id;
  DeleteClientParams({required this.id});
}

class UpdateClientStatusUseCase
    implements UseCase<UpdateClientMainResEntity, UpdateClientStatusParams> {
  final ClientRepository clientRepository;
  UpdateClientStatusUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, UpdateClientMainResEntity>> call(
      UpdateClientStatusParams params) async {
    return await clientRepository.updateClient(params);
  }
}

class UpdateClientStatusParams {
  String id;
  bool isActive;
  UpdateClientStatusParams({required this.id, required this.isActive});
}

class ClientDetailsUseCase
    implements UseCase<ClientDetailsMainResEntity, ClientDetailsReqParams> {
  final ClientRepository clientRepository;
  ClientDetailsUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, ClientDetailsMainResEntity>> call(
      ClientDetailsReqParams params) {
    return clientRepository.getDetails(params);
  }
}

class ClientDetailsReqParams {
  final String id;
  ClientDetailsReqParams({required this.id});
}
