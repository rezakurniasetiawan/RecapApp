import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:recipe/controller/splash_controller.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({super.key});
  // ignore: unused_field
  final SplashController _c = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset('assets/images/burger.png', width: 150),
            ),
          ),
        ],
      ),
    );
  }
}
