import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/models/country_model.dart';
import 'package:recipe_app/utils/theme_utils%20.dart';
import 'package:recipe_app/widget/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  var uuid = const Uuid();
  TextEditingController textController = TextEditingController();

  final List<CountryModel> listCountry = [];
  saveDataToStorage() async {
    final List<Object> tmp = [];
    for (var item in listCountry) {
      tmp.add(item.toJson());
    }
    await storage.write(key: 'master-country', value: jsonEncode(tmp));
    _getDataFromStorage();
  }

  _getDataFromStorage() async {
    String? data = await storage.read(key: 'master-country');
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (dataDecoded is List) {
        setState(() {
          listCountry.clear();
          for (var item in dataDecoded) {
            listCountry.insert(0, CountryModel.fromJson(item));
            print(listCountry);
          }
        });
      }
    }
  }

  void deleteData(int index) {
    setState(() {
      listCountry.removeAt(index);
    });
    saveDataToStorage(); // Simpan perubahan ke penyimpanan
  }

  void updateData(int index, String newName) {
    setState(() {
      listCountry[index].countryName = newName;
    });
    saveDataToStorage();
  }

  void showEditModal(int index) {
    textController.text = listCountry[index].countryName;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ShowModalBottomSheet(
            title: 'Edit Country',
            controller: textController,
            hintText: 'Enter new country name',
            press: () {
              updateData(index, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Country'),
          content: const Text('Are you sure you want to delete this country?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteData(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
        title: const Text('Country'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: ThemeUtils.primaryColor,
              size: 34.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ShowModalBottomSheet(
                          title: 'Add Country',
                          controller: textController,
                          hintText: 'Enter country name',
                          press: () {
                            listCountry.add(CountryModel(
                              uuId: uuid.v4(),
                              countryName: textController.text,
                            ));
                            textController.clear();
                            Navigator.pop(context);
                            saveDataToStorage();
                          },
                        ))),
              );
            },
          ),
        ],
      ),
      body: listCountry.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(
                //   child: SizedBox(
                //       height: 200,
                //       child: Image.asset('assets/data-kosong.png')),
                // ),
                Text(
                  'Data Kosong',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listCountry.length,
              itemBuilder: (context, index) {
                final country = listCountry[index];
                return ListTile(
                  title: Text(country.countryName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showEditModal(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDeleteConfirmationDialog(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
