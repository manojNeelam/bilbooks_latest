class NotificationMainResponseEntity {
  int? success;
  NotificationMainDataEntity? data;

  NotificationMainResponseEntity({
    this.success,
    this.data,
  });
}

class NotificationMainDataEntity {
  bool? success;
  List<ActivitylogEntity>? activitylog;
  String? message;

  NotificationMainDataEntity({
    this.success,
    this.activitylog,
    this.message,
  });
}

class ActivitylogEntity {
  String? activityId;
  String? organizationId;
  String? transactionType;
  String? operationType;
  String? parameters;
  String? userId;
  String? clientId;
  String? itemId;
  String? estimateId;
  String? invoiceId;
  String? paymentId;
  String? expenseId;
  String? categoryId;
  String? projectId;
  String? taxId;
  String? createdBy;
  DateTime? dateCreated;
  String? createdName;

  ActivitylogEntity({
    this.activityId,
    this.organizationId,
    this.transactionType,
    this.operationType,
    this.parameters,
    this.userId,
    this.clientId,
    this.itemId,
    this.estimateId,
    this.invoiceId,
    this.paymentId,
    this.expenseId,
    this.categoryId,
    this.projectId,
    this.taxId,
    this.createdBy,
    this.dateCreated,
    this.createdName,
  });
}
