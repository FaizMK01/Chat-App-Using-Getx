import 'package:get/get.dart';

class LoginOrRegisterController extends GetxController {
  var showLoginPage = true.obs;

  void togglePage() {
    showLoginPage.value = !showLoginPage.value;
  }
}
