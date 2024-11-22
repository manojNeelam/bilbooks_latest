import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_details_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/delete_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/update_status_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/add_client_entity.dart';
import '../usecase/add_client_usecase.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, ClientResponseEntity>> getList(
      ClientListParams params);
  Future<Either<Failure, DeleteClientMainResEntity>> deleteClient(
      DeleteClientParams paras);

  Future<Either<Failure, UpdateClientMainResEntity>> updateClient(
      UpdateClientStatusParams params);

  Future<Either<Failure, ClientDetailsMainResEntity>> getDetails(
      ClientDetailsReqParams params);

  Future<Either<Failure, ClientAddMainResEntity>> addClient(
      AddClientUsecaseReqParams params);
}
