import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/integrations/data/datasource/integration_remote_datasource.dart';

import 'package:billbooks_app/features/integrations/domain/entity/online_payment_details_entity.dart';
import 'package:billbooks_app/features/integrations/domain/entity/update_online_payment_entity.dart';

import 'package:billbooks_app/features/integrations/domain/usecase/online_payment_details_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_exception.dart';
import '../../domain/repository/online_payment_repository.dart';

class OnlinePaymentRepositoryImpl implements OnlinePaymentRepository {
  final OnlinePaymentsRemoteDatasource onlinePaymentsRemoteDatasource;
  OnlinePaymentRepositoryImpl({required this.onlinePaymentsRemoteDatasource});
  @override
  Future<Either<Failure, OnlinePaymentMainResponseEntity>>
      getOnlinePaymentDetails(OnlinePaymentDetailsReqParms params) async {
    try {
      final responseBody =
          await onlinePaymentsRemoteDatasource.getOnlinePaymentDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> updatePayPalDetails(
      PaypalUsecaseReqParams params) async {
    try {
      final responseBody =
          await onlinePaymentsRemoteDatasource.updatePayPalDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
      updateAuthorizeDetailsDetails(AuthorizeUsecaseReqParams params) async {
    try {
      final responseBody =
          await onlinePaymentsRemoteDatasource.updateAuthoriseDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
      updateBrainTreeDetails(BrainTreeUseCaseUsecaseReqParams params) async {
    try {
      final responseBody =
          await onlinePaymentsRemoteDatasource.updateBrainTreeDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
      updateCheckoutDetails(CheckoutUseCaseUsecaseReqParams params) async {
    try {
      final responseBody =
          await onlinePaymentsRemoteDatasource.updateCheckoutDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> updateStripeDetails(
      StripeUseCaseReqParams params) async {
    try {
      final responseBody =
          await onlinePaymentsRemoteDatasource.updateStripeDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
