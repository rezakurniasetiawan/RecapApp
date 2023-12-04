import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recipe/constant.dart';
import 'package:recipe/data/database_helper.dart';
import 'package:recipe/data/models/recipe_entities.dart';

enum TypeDashboard { countries, food }

class HomeController extends GetxController {
  static HomeController instance = Get.put(HomeController());
  final Rx<List> _countryList = Rx<List>([]);
  final Rx<List> _filterCountryList = Rx<List>([]);
  final Rx<Status> _loading = Rx<Status>(Status.empty);
  final Rx<TypeDashboard> _type = Rx<TypeDashboard>(TypeDashboard.countries);
  final Rx<List<RecipeEntities>> _listRecipe = Rx<List<RecipeEntities>>([]);
  final Rx<List<RecipeEntities>> _filteredListRecipe = Rx<List<RecipeEntities>>([]);

  List get countryList => _countryList.value;
  List get filterCountryList => _filterCountryList.value;
  Status get loading => _loading.value;
  TypeDashboard get type => _type.value;
  List<RecipeEntities> get listRecipe => _listRecipe.value;
  List<RecipeEntities> get filteredListRecipe => _filteredListRecipe.value;

  @override
  void onInit() {
    super.onInit();
    Future.microtask(() {
      loadCountries();
      getRecipeList();
    });
  }

  Future<void> loadCountries() async {
    try {
      _loading.value = Status.loading;
      String content = await rootBundle.loadString('assets/data/parsed_countries.json');

      List<dynamic> countries = jsonDecode(content);
      _countryList.value = countries;
      _filterCountryList.value = countries;
      _loading.value = Status.success;
    } catch (e) {
      _loading.value = Status.failed;
    }
  }

  Future<void> getRecipeList() async {
    final sql = DatabaseHelper();
    final list = await sql.getRecipe();
    _listRecipe.value = list;
    _filteredListRecipe.value = list;
  }

  void search(String keyword) async {
    if (type == TypeDashboard.countries) {
      _filterCountryList.value = countryList.where((element) => element["name"].toLowerCase().contains(keyword.toLowerCase())).toList();
    } else {
      _filteredListRecipe.value = listRecipe.where((element) => element.name!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
  }

  void changeType(TypeDashboard type) {
    _type.value = type;
  }
}
