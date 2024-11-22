class ClientPersonModel {
  String name;
  String email;
  String phoneNumber;
  ClientPersonModel(
      {required this.name, required this.email, this.phoneNumber = ""});
}
