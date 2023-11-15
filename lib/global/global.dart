import 'package:skysoft_taxi/models/user.model.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  UserModel driverModel = UserModel(
    role: "TX",
    status: Status.NORMAL,
    name: "",
    description: "",
  );
  UserModel userModel =
      UserModel(role: "ND", status: Status.NORMAL, name: "", description: "");
}

UserModel driverModel = GlobalData().driverModel;
UserModel userModel = GlobalData().userModel;
