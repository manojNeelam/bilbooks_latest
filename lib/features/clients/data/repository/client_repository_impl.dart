import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/clients/data/datasource/remote/client_remote_datasource.dart';
import 'package:billbooks_app/features/clients/domain/entities/add_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_details_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/delete_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/update_status_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/add_client_usecase.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/repository/client_repository.dart';

final class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource clientRemoteDataSource;
  ClientRepositoryImpl(this.clientRemoteDataSource);

  @override
  Future<Either<Failure, ClientResponseEntity>> getList(
      ClientListParams params) async {
    try {
      final res = await clientRemoteDataSource.getList(params);
      debugPrint("Client Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Client Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Client Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteClientMainResEntity>> deleteClient(
      DeleteClientParams params) async {
    try {
      final res = await clientRemoteDataSource.deleteClient(params);
      debugPrint("Client Delete Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Client Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Client Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateClientMainResEntity>> updateClient(
      UpdateClientStatusParams params) async {
    try {
      final res = await clientRemoteDataSource.updateClientStatus(params);
      debugPrint("Update Client Status Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Client Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Client Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientDetailsMainResEntity>> getDetails(
      ClientDetailsReqParams params) async {
    try {
      final res = await clientRemoteDataSource.getDetails(params);
      return right(res);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientAddMainResEntity>> addClient(
      AddClientUsecaseReqParams params) async {
    try {
      final res = await clientRemoteDataSource.addClient(params);
      return right(res);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
