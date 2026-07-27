class SubscriptionMainResponseEntity {
  int? success;
  SubscriptionDataEntity? data;

  SubscriptionMainResponseEntity({
    this.success,
    this.data,
  });
}

class SubscriptionDataEntity {
  bool? success;
  CurrentSubscriptionEntity? subscription;
  SubscriptionPlansEntity? plans;
  SubscriptionCardDetailsEntity? carddetails;
  SubscriptionPagingEntity? paging;
  List<SubscriptionTransactionEntity>? transactions;
  bool? showCoupon;

  SubscriptionDataEntity({
    this.success,
    this.subscription,
    this.plans,
    this.carddetails,
    this.paging,
    this.transactions,
    this.showCoupon,
  });
}

class CurrentSubscriptionEntity {
  String? id;
  String? name;
  String? frequency;
  String? startdate;
  String? enddate;
  String? amount;
  String? days;
  bool? isExpired;
  String? status;
  String? maxClients;
  String? maxItems;
  String? maxProjects;
  String? maxExpenses;
  String? maxUsers;
  String? maxInvoices;
  String? maxEstimates;
  String? multipleOrganization;

  CurrentSubscriptionEntity({
    this.id,
    this.name,
    this.frequency,
    this.startdate,
    this.enddate,
    this.amount,
    this.days,
    this.isExpired,
    this.status,
    this.maxClients,
    this.maxItems,
    this.maxProjects,
    this.maxExpenses,
    this.maxUsers,
    this.maxInvoices,
    this.maxEstimates,
    this.multipleOrganization,
  });
}

class SubscriptionPlansEntity {
  List<SubscriptionPlanEntity>? monthly;
  List<SubscriptionPlanEntity>? yearly;

  SubscriptionPlansEntity({
    this.monthly,
    this.yearly,
  });
}

class SubscriptionPlanEntity {
  String? id;
  String? name;
  String? price;
  String? maxClients;
  String? maxItems;
  String? maxProjects;
  String? maxExpenses;
  String? maxUsers;
  String? maxInvoices;
  String? maxEstimates;
  String? multipleOrganization;
  bool? isActive;
  bool? isRenew;
  bool? isBuy;
  String? buybtnText;
  String? buybtnAction;
  bool? isDisabled;

  SubscriptionPlanEntity({
    this.id,
    this.name,
    this.price,
    this.maxClients,
    this.maxItems,
    this.maxProjects,
    this.maxExpenses,
    this.maxUsers,
    this.maxInvoices,
    this.maxEstimates,
    this.multipleOrganization,
    this.isActive,
    this.isRenew,
    this.isBuy,
    this.buybtnText,
    this.buybtnAction,
    this.isDisabled,
  });
}

class SubscriptionCardDetailsEntity {
  String? type;
  String? number;
  String? image;

  SubscriptionCardDetailsEntity({
    this.type,
    this.number,
    this.image,
  });
}

class SubscriptionPagingEntity {
  int? from;
  int? to;
  int? totalrecords;
  int? totalpages;
  int? currentpage;
  int? offset;
  int? length;
  int? remainingrecords;

  SubscriptionPagingEntity({
    this.from,
    this.to,
    this.totalrecords,
    this.totalpages,
    this.currentpage,
    this.offset,
    this.length,
    this.remainingrecords,
  });
}

class SubscriptionTransactionEntity {
  String? orderId;
  String? organizationId;
  String? invoiceNo;
  String? date;
  String? operationType;
  String? planId;
  String? planFrequency;
  String? planStartdate;
  String? planEnddate;
  String? amount;
  String? discperc;
  String? discamnt;
  String? refund;
  String? bonusdays;
  String? nettotal;
  String? currency;
  String? nextBilling;
  String? billingAmount;
  String? status;
  String? txnId;
  String? createdBy;
  String? planName;

  SubscriptionTransactionEntity({
    this.orderId,
    this.organizationId,
    this.invoiceNo,
    this.date,
    this.operationType,
    this.planId,
    this.planFrequency,
    this.planStartdate,
    this.planEnddate,
    this.amount,
    this.discperc,
    this.discamnt,
    this.refund,
    this.bonusdays,
    this.nettotal,
    this.currency,
    this.nextBilling,
    this.billingAmount,
    this.status,
    this.txnId,
    this.createdBy,
    this.planName,
  });
}
