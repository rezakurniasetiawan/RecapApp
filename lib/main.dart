import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:recipe/view/pages/country_list_page.dart';
import 'package:recipe/view/pages/home_page.dart';
import 'package:recipe/view/pages/master_data_page.dart';
import 'package:recipe/view/pages/splash_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: SplashScreenPage(),
      getPages: [
        GetPage(name: '/splashscreen', page: () => SplashScreenPage()),
        GetPage(name: '/home', page: () => HomePage(), transition: Transition.cupertino),
        GetPage(name: '/country-list', page: () => CountryListPage(), transition: Transition.cupertino),
        GetPage(name: '/master-data', page: () => MasterDataPage(), transition: Transition.cupertino),
      ],
    );
  }
}
