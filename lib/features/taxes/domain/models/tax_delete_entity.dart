// To parse this JSON data, do
//
//     final taxDeleteMainResEnity = taxDeleteMainResEnityFromJson(jsonString);

class TaxDeleteMainResEnity {
  int? success;
  TaxDeleteDataEnity? data;

  TaxDeleteMainResEnity({
    this.success,
    this.data,
  });
}

class TaxDeleteDataEnity {
  bool? success;
  String? message;

  TaxDeleteDataEnity({
    this.success,
    this.message,
  });
}
