import 'package:billbooks_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../../core/api/api_exception.dart';
import '../../domain/entity/subscription_entity.dart';
import '../../domain/repository/subscription_repository.dart';
import '../../domain/usecase/subscription_usecase.dart';
import '../remote/subscription_remote_datasource.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDatasource subscriptionRemoteDatasource;

  SubscriptionRepositoryImpl({required this.subscriptionRemoteDatasource});

  @override
  Future<Either<Failure, SubscriptionMainResponseEntity>> getSubscription(
      SubscriptionReqParams params) async {
    try {
      final responseBody =
          await subscriptionRemoteDatasource.getSubscription(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
