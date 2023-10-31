import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/view/pages/add_recipe_page.dart';
import 'package:recipe/view/pages/add_stuff_page.dart';
import 'package:recipe/view/pages/edit_recipe_page.dart';
import 'package:recipe/view/pages/edit_stuff_page.dart';
import 'package:recipe/view/pages/home_page.dart';
import 'package:recipe/view/pages/master_data_page.dart';
import 'package:recipe/view/pages/recipe_on_country.dart';
import 'package:recipe/view/pages/recipe_page.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        appBarTheme: AppBarTheme(
          foregroundColor: textColor,
          elevation: 0,
          titleTextStyle: CustomTextTheme.heading4,
          backgroundColor: backgroundColor,
        ),
      ),
      home: SplashScreenPage(),
      getPages: [
        GetPage(name: '/splashscreen', page: () => SplashScreenPage()),
        GetPage(name: '/home', page: () => HomePage(), transition: Transition.cupertino),
        GetPage(name: '/master-data', page: () => MasterDataPage(), transition: Transition.cupertino),
        GetPage(name: '/master-data/stuff', page: () => AddStuffPage(), transition: Transition.cupertino),
        GetPage(name: '/master-data/stuff/edit', page: () => EditStuffPage(), transition: Transition.cupertino),
        GetPage(name: '/master-data/recipe', page: () => AddRecipePage(), transition: Transition.cupertino),
        GetPage(name: '/master-data/recipe/edit', page: () => EditRecipePage(), transition: Transition.cupertino),
        GetPage(name: '/recipe', page: () => RecipePage(), transition: Transition.cupertino),
        GetPage(name: '/recipe-country', page: () => RecipeOnCountry(), transition: Transition.cupertino),
      ],
    );
  }
}
