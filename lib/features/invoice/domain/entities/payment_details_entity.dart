import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';

class PaymentDetailMainResEntity {
  int? success;
  PaymentDetailDataEntity? data;

  PaymentDetailMainResEntity({
    this.success,
    this.data,
  });
}

class PaymentDetailDataEntity {
  bool? success;
  PaymentEntity? payments;
  String? message;

  PaymentDetailDataEntity({
    this.success,
    this.payments,
    this.message,
  });
}
