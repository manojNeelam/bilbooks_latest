import 'package:billbooks_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/subscription_entity.dart';
import '../usecase/subscription_usecase.dart';

abstract interface class SubscriptionRepository {
  Future<Either<Failure, SubscriptionMainResponseEntity>> getSubscription(
      SubscriptionReqParams params);
}
