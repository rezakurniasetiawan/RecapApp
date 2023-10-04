import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/models/country_model.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final List<CountryModel> listCountry = [];
  final TextEditingController countryId = TextEditingController();
  final TextEditingController foodName = TextEditingController();
  _getDataFromStorage() async {
    String? data = await storage.read(key: 'master-country');
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (dataDecoded is List) {
        setState(() {
          listCountry.clear();
          for (var item in dataDecoded) {
            listCountry.insert(0, CountryModel.fromJson(item));
          }
        });
      }
    }
  }

  @override
  void initState() {
    _getDataFromStorage();
    super.initState();
  }

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Food'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Country',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownSearch<String>(
                items: listCountry.map((country) => country.uuId).toList(),
                onChanged: (String? selectedCountry) {
                  print(selectedCountry);
                },
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: foodName,
                  style: const TextStyle(
                      fontFamily: 'Roboto', fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Countr',
                    hintStyle: TextStyle(fontSize: 14.0, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
