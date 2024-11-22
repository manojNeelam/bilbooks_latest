import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/integrations/domain/usecase/online_payment_details_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/online_payment_details_entity.dart';
import '../entity/update_online_payment_entity.dart';

abstract interface class OnlinePaymentRepository {
  Future<Either<Failure, OnlinePaymentMainResponseEntity>>
      getOnlinePaymentDetails(OnlinePaymentDetailsReqParms params);
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> updatePayPalDetails(
      PaypalUsecaseReqParams params);
  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
      updateAuthorizeDetailsDetails(AuthorizeUsecaseReqParams params);

  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
      updateBrainTreeDetails(BrainTreeUseCaseUsecaseReqParams params);

  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
      updateCheckoutDetails(CheckoutUseCaseUsecaseReqParams params);

  Future<Either<Failure, UpdateOnlinePaymentMainResEntity>> updateStripeDetails(
      StripeUseCaseReqParams params);

  // Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
  // updateAuthorizeDetailsDetails(AuthorizeUsecaseReqParams params);
  // Future<Either<Failure, UpdateOnlinePaymentMainResEntity>>
  // updateAuthorizeDetailsDetails(AuthorizeUsecaseReqParams params);
}
