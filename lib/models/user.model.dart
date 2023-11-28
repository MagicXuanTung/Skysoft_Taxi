// ignore_for_file: constant_identifier_names

enum Status { BUSY, NORMAL }

class UserModel {
  String role;
  Status status = Status.NORMAL;
  String name;
  String type;
  String description;

  UserModel({
    required this.role,
    required this.type,
    required this.status,
    required this.name,
    required this.description,
  });

  void changeStatusWithMessage(String mes) {
    if (mes == "ACPECT") {
      status = Status.BUSY;
    } else if (mes == "ENDTRIP") {
      status = Status.NORMAL;
    }
  }
}
