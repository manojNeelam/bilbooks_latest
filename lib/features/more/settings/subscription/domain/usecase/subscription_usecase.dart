import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/subscription_entity.dart';
import '../repository/subscription_repository.dart';

class GetSubscriptionUsecase
    implements UseCase<SubscriptionMainResponseEntity, SubscriptionReqParams> {
  final SubscriptionRepository subscriptionRepository;

  GetSubscriptionUsecase({required this.subscriptionRepository});

  @override
  Future<Either<Failure, SubscriptionMainResponseEntity>> call(
      SubscriptionReqParams params) {
    return subscriptionRepository.getSubscription(params);
  }
}

class SubscriptionReqParams {
  final int page;
  final int perPage;

  SubscriptionReqParams({
    this.page = 1,
    this.perPage = 10,
  });
}
