import 'package:get_storage/get_storage.dart';

class FunctionUser {
  savePassword(password) {
    var box = GetStorage();
    box.write('password', password);
  }

  readPassword() {
    var box = GetStorage();
    var password = box.read('password') ?? '';
    return password;
  }
}
