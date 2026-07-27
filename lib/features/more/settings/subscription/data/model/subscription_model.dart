import '../../domain/entity/subscription_entity.dart';

class SubscriptionMainResponseModel extends SubscriptionMainResponseEntity {
  SubscriptionMainResponseModel({
    int? success,
    SubscriptionDataModel? data,
  }) : super(success: success, data: data);

  factory SubscriptionMainResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionMainResponseModel(
      success: json['success'],
      data: json['data'] == null
          ? null
          : SubscriptionDataModel.fromJson(json['data']),
    );
  }
}

class SubscriptionDataModel extends SubscriptionDataEntity {
  SubscriptionDataModel({
    bool? success,
    CurrentSubscriptionModel? subscription,
    SubscriptionPlansModel? plans,
    SubscriptionCardDetailsModel? carddetails,
    SubscriptionPagingModel? paging,
    List<SubscriptionTransactionModel>? transactions,
    bool? showCoupon,
  }) : super(
          success: success,
          subscription: subscription,
          plans: plans,
          carddetails: carddetails,
          paging: paging,
          transactions: transactions,
          showCoupon: showCoupon,
        );

  factory SubscriptionDataModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionDataModel(
      success: json['success'],
      subscription: json['subscription'] == null
          ? null
          : CurrentSubscriptionModel.fromJson(json['subscription']),
      plans: json['plans'] == null
          ? null
          : SubscriptionPlansModel.fromJson(json['plans']),
      carddetails: json['carddetails'] == null
          ? null
          : SubscriptionCardDetailsModel.fromJson(json['carddetails']),
      paging: json['paging'] == null
          ? null
          : SubscriptionPagingModel.fromJson(json['paging']),
      transactions: (json['transactions'] as List<dynamic>? ?? [])
          .map((item) => SubscriptionTransactionModel.fromJson(item))
          .toList(),
      showCoupon: json['show_coupon'],
    );
  }
}

class CurrentSubscriptionModel extends CurrentSubscriptionEntity {
  CurrentSubscriptionModel({
    super.id,
    super.name,
    super.frequency,
    super.startdate,
    super.enddate,
    super.amount,
    super.days,
    super.isExpired,
    super.status,
    super.maxClients,
    super.maxItems,
    super.maxProjects,
    super.maxExpenses,
    super.maxUsers,
    super.maxInvoices,
    super.maxEstimates,
    super.multipleOrganization,
  });

  factory CurrentSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return CurrentSubscriptionModel(
      id: json['id'],
      name: json['name'],
      frequency: json['frequency'],
      startdate: json['startdate'],
      enddate: json['enddate'],
      amount: json['amount'],
      days: json['days'],
      isExpired: json['is_expired'],
      status: json['status'],
      maxClients: json['max_clients'],
      maxItems: json['max_items'],
      maxProjects: json['max_projects'],
      maxExpenses: json['max_expenses'],
      maxUsers: json['max_users'],
      maxInvoices: json['max_invoices'],
      maxEstimates: json['max_estimates'],
      multipleOrganization: json['multiple_organization'],
    );
  }
}

class SubscriptionPlansModel extends SubscriptionPlansEntity {
  SubscriptionPlansModel({
    List<SubscriptionPlanModel>? monthly,
    List<SubscriptionPlanModel>? yearly,
  }) : super(monthly: monthly, yearly: yearly);

  factory SubscriptionPlansModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlansModel(
      monthly: (json['monthly'] as List<dynamic>? ?? [])
          .map((item) => SubscriptionPlanModel.fromJson(item))
          .toList(),
      yearly: (json['yearly'] as List<dynamic>? ?? [])
          .map((item) => SubscriptionPlanModel.fromJson(item))
          .toList(),
    );
  }
}

class SubscriptionPlanModel extends SubscriptionPlanEntity {
  SubscriptionPlanModel({
    super.id,
    super.name,
    super.price,
    super.maxClients,
    super.maxItems,
    super.maxProjects,
    super.maxExpenses,
    super.maxUsers,
    super.maxInvoices,
    super.maxEstimates,
    super.multipleOrganization,
    super.isActive,
    super.isRenew,
    super.isBuy,
    super.buybtnText,
    super.buybtnAction,
    super.isDisabled,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      maxClients: json['max_clients'],
      maxItems: json['max_items'],
      maxProjects: json['max_projects'],
      maxExpenses: json['max_expenses'],
      maxUsers: json['max_users'],
      maxInvoices: json['max_invoices'],
      maxEstimates: json['max_estimates'],
      multipleOrganization: json['multiple_organization'],
      isActive: json['is_active'],
      isRenew: json['is_renew'],
      isBuy: json['is_buy'],
      buybtnText: json['buybtn_text'],
      buybtnAction: json['buybtn_action'],
      isDisabled: json['is_disabled'],
    );
  }
}

class SubscriptionCardDetailsModel extends SubscriptionCardDetailsEntity {
  SubscriptionCardDetailsModel({
    super.type,
    super.number,
    super.image,
  });

  factory SubscriptionCardDetailsModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionCardDetailsModel(
      type: json['type'],
      number: json['number'],
      image: json['image'],
    );
  }
}

class SubscriptionPagingModel extends SubscriptionPagingEntity {
  SubscriptionPagingModel({
    super.from,
    super.to,
    super.totalrecords,
    super.totalpages,
    super.currentpage,
    super.offset,
    super.length,
    super.remainingrecords,
  });

  factory SubscriptionPagingModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPagingModel(
      from: json['from'],
      to: json['to'],
      totalrecords: json['totalrecords'],
      totalpages: json['totalpages'],
      currentpage: json['currentpage'],
      offset: json['offset'],
      length: json['length'],
      remainingrecords: json['remainingrecords'],
    );
  }
}

class SubscriptionTransactionModel extends SubscriptionTransactionEntity {
  SubscriptionTransactionModel({
    super.orderId,
    super.organizationId,
    super.invoiceNo,
    super.date,
    super.operationType,
    super.planId,
    super.planFrequency,
    super.planStartdate,
    super.planEnddate,
    super.amount,
    super.discperc,
    super.discamnt,
    super.refund,
    super.bonusdays,
    super.nettotal,
    super.currency,
    super.nextBilling,
    super.billingAmount,
    super.status,
    super.txnId,
    super.createdBy,
    super.planName,
  });

  factory SubscriptionTransactionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionTransactionModel(
      orderId: json['order_id'],
      organizationId: json['organization_id'],
      invoiceNo: json['invoice_no'],
      date: json['date'],
      operationType: json['operation_type'],
      planId: json['plan_id'],
      planFrequency: json['plan_frequency'],
      planStartdate: json['plan_startdate'],
      planEnddate: json['plan_enddate'],
      amount: json['amount'],
      discperc: json['discperc'],
      discamnt: json['discamnt'],
      refund: json['refund'],
      bonusdays: json['bonusdays'],
      nettotal: json['nettotal'],
      currency: json['currency'],
      nextBilling: json['next_billing'],
      billingAmount: json['billing_amount'],
      status: json['status'],
      txnId: json['txn_id'],
      createdBy: json['created_by'],
      planName: json['plan_name'],
    );
  }
}
