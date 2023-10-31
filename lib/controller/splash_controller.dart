import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController instance = Get.find();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        Get.offAndToNamed('/home');
      },
    );
  }
}
