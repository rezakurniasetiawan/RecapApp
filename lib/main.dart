import 'package:flutter/material.dart';
import 'package:recipe_app/screens/dashboard/dashboard_screen.dart';
import 'package:recipe_app/screens/master_data/countrys/country_screen.dart';
import 'package:recipe_app/screens/master_data/foods/add_food_screen.dart';
import 'package:recipe_app/screens/master_data/foods/foods_screen.dart';
import 'package:recipe_app/screens/master_data/menu_master_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/country': (context) => const CountryScreen(),
        '/food': (context) => const FoodScreen(),
        '/master': (context) => const MenuMasterData(),
        '/addfood': (context) => const AddFoodScreen(),
      },
    );
  }
}
