import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';

class PaymentListMainResEntity {
  int? success;
  PaymentDataEntity? data;

  PaymentListMainResEntity({
    this.success,
    this.data,
  });
}

class PaymentDataEntity {
  bool? success;
  List<PaymentEntity>? payments;
  String? balance;
  String? message;

  PaymentDataEntity({
    this.success,
    this.payments,
    this.balance,
    this.message,
  });
}
