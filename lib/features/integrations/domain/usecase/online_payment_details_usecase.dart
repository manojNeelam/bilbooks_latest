import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/integrations/domain/repository/online_payment_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/online_payment_details_entity.dart';
import '../entity/update_online_payment_entity.dart';

class OnlinePaymentDetailsUsecase
    implements
        UseCase<OnlinePaymentMainResponseEntity, OnlinePaymentDetailsReqParms> {
  final OnlinePaymentRepository onlinePaymentRepository;
  OnlinePaymentDetailsUsecase({required this.onlinePaymentRepository});
  @override
  Future<Either<Failure, OnlinePaymentMainResponseEntity>> call(
      OnlinePaymentDetailsReqParms params) {
    return onlinePaymentRepository.getOnlinePaymentDetails(params);
  }
}

class OnlinePaymentDetailsReqParms {}

class PaypalUsecase
    implements
        UseCase<UpdateOnlinePaymentMainResEntity, PaypalUsecaseReqParams> {
  final OnlinePaymentRepository onlinePaymentRepository;

  PaypalUsecase({required this.onlinePaymentRepository});
  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> call(
      PaypalUsecaseReqParams params) {
    return onlinePaymentRepository.updatePayPalDetails(params);
  }
}

class PaypalUsecaseReqParams {
  final String paypalid;
  PaypalUsecaseReqParams({required this.paypalid});
}

class AuthorizeUseCase
    implements
        UseCase<UpdateOnlinePaymentMainResEntity, AuthorizeUsecaseReqParams> {
  final OnlinePaymentRepository onlinePaymentRepository;

  AuthorizeUseCase({required this.onlinePaymentRepository});
  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> call(
      AuthorizeUsecaseReqParams params) {
    return onlinePaymentRepository.updateAuthorizeDetailsDetails(params);
  }
}

class AuthorizeUsecaseReqParams {
  final String authoriseId, authriseTransactionKey;
  AuthorizeUsecaseReqParams(
      {required this.authoriseId, required this.authriseTransactionKey});
}

class BrainTreeUseCase
    implements
        UseCase<UpdateOnlinePaymentMainResEntity,
            BrainTreeUseCaseUsecaseReqParams> {
  final OnlinePaymentRepository onlinePaymentRepository;

  BrainTreeUseCase({required this.onlinePaymentRepository});
  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> call(
      BrainTreeUseCaseUsecaseReqParams params) {
    return onlinePaymentRepository.updateBrainTreeDetails(params);
  }
}

class BrainTreeUseCaseUsecaseReqParams {
  final String merchantId, publickey, privateKey;
  BrainTreeUseCaseUsecaseReqParams(
      {required this.merchantId,
      required this.publickey,
      required this.privateKey});
}

class CheckoutUseCase
    implements
        UseCase<UpdateOnlinePaymentMainResEntity,
            CheckoutUseCaseUsecaseReqParams> {
  final OnlinePaymentRepository onlinePaymentRepository;

  CheckoutUseCase({required this.onlinePaymentRepository});
  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> call(
      CheckoutUseCaseUsecaseReqParams params) {
    return onlinePaymentRepository.updateCheckoutDetails(params);
  }
}

class CheckoutUseCaseUsecaseReqParams {
  final String accountId, secret;
  CheckoutUseCaseUsecaseReqParams({
    required this.accountId,
    required this.secret,
  });
}

class StripeUseCase
    implements
        UseCase<UpdateOnlinePaymentMainResEntity, StripeUseCaseReqParams> {
  final OnlinePaymentRepository onlinePaymentRepository;

  StripeUseCase({required this.onlinePaymentRepository});
  @override
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> call(
      StripeUseCaseReqParams params) {
    return onlinePaymentRepository.updateStripeDetails(params);
  }
}

class StripeUseCaseReqParams {
  final String id, publishableKey;
  StripeUseCaseReqParams({
    required this.id,
    required this.publishableKey,
  });
}
