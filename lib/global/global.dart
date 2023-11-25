import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
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
    type: "",
  );

  UserModel userModel = UserModel(
      role: "ND", status: Status.NORMAL, name: "", description: "", type: "");
}

UserModel driverModel = GlobalData().driverModel;
UserModel userModel = GlobalData().userModel;

// kết nối bộ đàm bluetooth
BluetoothConnection? connection;
