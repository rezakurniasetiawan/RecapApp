import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/models/country_model.dart';
import 'package:recipe_app/screens/dashboard/component/app_bar_dashboard.dart';
import 'package:recipe_app/screens/dashboard/component/banner_dashboar.dart';
import 'package:recipe_app/screens/dashboard/component/search_dashboard.dart';

import '../../utils/theme_utils .dart';
import '../../widget/title_top.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final storage = const FlutterSecureStorage();
  final TextEditingController searchController = TextEditingController();

  final List<CountryModel> listCountry = [];
  List<CountryModel> filteredCountries = [];

  _getDataFromStorage() async {
    String? data = await storage.read(key: 'master-country');
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (dataDecoded is List) {
        setState(() {
          listCountry.clear();
          filteredCountries.clear();
          for (var item in dataDecoded) {
            listCountry.insert(0, CountryModel.fromJson(item));
            filteredCountries.insert(0, CountryModel.fromJson(item));
          }
        });
      }
    }
  }

  void filterCountries(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredCountries = listCountry.toList();
      } else {
        filteredCountries = listCountry.where((country) => country.countryName.toLowerCase().contains(keyword.toLowerCase())).toList();
      }
    });
  }

  @override
  void initState() {
    _getDataFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          _getDataFromStorage();
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    const AppBarDashboard(),
                    SearchDashboard(
                      onSearchTextChanged: (value) {
                        filterCountries(value);
                      },
                    ),
                    BannerDashboard(
                      press: () {
                        Navigator.pushNamed(context, '/master');
                      },
                    ),
                    const TitleTop(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ThemeUtils.primaryColor.withOpacity(0.1)),
                            child: Text(
                              country.countryName,
                              style: TextStyle(color: ThemeUtils.ColorBlack, fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
