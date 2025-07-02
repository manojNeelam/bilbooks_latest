class ApiEndPoints {
  ApiEndPoints._();

  ///Login
  static const String login = "auth/login";
  static const String logout = "logout";
  static const String resetPassword = "auth/resetpassword";
  static const String authUser = "auth/signup";

  //profile
  static const String updateProfile = "auth/profile";

  //Client
  static const String client = "clients";
  static const String deleteClient = "clients/delete";
  static const String inActiveClient = "clients/makeinactive";
  static const String activeClient = "clients/makeactive";
  static const String clientStaff = "clients/staffs";
  static const String clientDetails = "clients/details";
  static const String addClient = "clients/entry";

  //Invoice Details
  static const String invoiceDetails = "invoices/details";
  static const String invoices = "invoices";
  static const String addinvoice = "invoices/entry";

  //Items
  static const String itemList = "items";
  static const String addItem = "items/entry";
  static const String deleteItem = "items/delete";
  static const String itemInActive = "items/makeinactive";
  static const String itemActive = "items/makeactive";

  //Taxes
  static const String taxList = "taxes";
  static const String addTax = "taxes/entry";
  static const String deleteTax = "taxes/delete";

  //Project
  static const String projects = "projects";
  static const String addProjects = "projects/entry";
  static const String deleteProject = "projects/delete";
  static const String projectMakeActive = "projects/makeactive";
  static const String projectMakeInActive = "projects/makeinactive";
  static const String projectDetails = "projects/details";

  //User
  static const String users = "users";

  //Expenses
  static const String expenses = "expenses";
  static const String addExpenses = "expenses/entry";
  static const String deleteExpenses = "expenses/delete";

  //Catgeories
  static const String categories = "expenses/categories";

  //Invoice
  static const String paymentList = "invoices/paymentlist";
  static const String paymentDelete = "invoices/payment_delete";
  static const String paymentDetails = "invoices/payment_details";
  static const String invoiceMarkAsSend = "invoices/markassent";
  static const String invoiceVoid = "invoices/void";
  static const String invoiceUnVoid = "invoices/unvoid";
  static const String invoiceDelete = "invoices/delete";
  static const String invoicePDF = "invoices/pdf";
  static const String getDocuments = "send/document";
  static const String deletePayment = "invoices/payment_delete";
  static const String addPayment = "invoices/payment_entry";
  static const String sendThankYou = "send/thankyou";
  static const String sendReminder = "send/reminder";

  //Estimates
  static const String addEstimate = "estimates/entry";
  static const String estimates = "estimates";
  static const String estimateDetails = "estimates/details";
  static const String estimateMarkAsSent = "estimates/markassent";
  static const String estimateDelete = "estimates/delete";

  static const String organization = "settings/organization";
  static const String preferences = "settings/preferences";
  //onlinepayments
  static const String onlinepayments = "settings/onlinepayments";

  //Dashboard
  static const String salesandexpenses = "dashboard/salesandexpenses";
  static const String overdueinvoices = "dashboard/overdueinvoices";
  static const String accountsreceivables = "dashboard/accountsreceivables";
  static const String totalincomes = "dashboard/totalincomes";
  static const String totalreceivables = "dashboard/totalreceivables";
  static const String authInfo = "auth/info";
  static const String latestactivity = "dashboard/latestactivity";

  //Settings
  static const String selectorganization = "settings/selectorganization";
  static const String emailTemplates = "settings/emailtemplates";
  static const String updateEmailTemplates = "settings/emailtemplates";

  // Credit Notes
  static const String creditNotes = "creditnote";
  //Reports
  static const String invoiceReport = "reports/invoices";
  static const String outstandingReport = "reports/invoices";
}
