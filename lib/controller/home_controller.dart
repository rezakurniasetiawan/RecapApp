import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recipe/constant.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.put(HomeController());
  final Rx<List> _countryList = Rx<List>([]);
  final Rx<List> _filterCountryList = Rx<List>([]);
  final Rx<Status> _loading = Rx<Status>(Status.empty);

  List get countryList => _countryList.value;
  List get filterCountryList => _filterCountryList.value;
  Status get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    Future.microtask(() => loadCountries());
  }

  Future<void> loadCountries() async {
    try {
      _loading.value = Status.loading;
      String content = await rootBundle.loadString('assets/data/countries.json');

      List<dynamic> countries = jsonDecode(content);
      _countryList.value = countries;
      _filterCountryList.value = countries;
      _loading.value = Status.success;
    } catch (e) {
      _loading.value = Status.failed;
    }
  }

  void searchCountries(String keyword) async {
    if (keyword != '') {
      _filterCountryList.value = countryList.where((element) => element.toString().toLowerCase().contains(keyword.toLowerCase())).toList();
    } else {
      _filterCountryList.value = countryList;
    }
  }
}
