import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/data/database_helper.dart';
import 'package:recipe/data/models/recipe_entities.dart';
import 'package:recipe/data/models/stuff_entities.dart';
import 'package:recipe/data/models/stuff_on_recipe_entities.dart';

class StuffUnit {
  final String? name;
  final String? value;

  StuffUnit({this.name, this.value});
}

enum DataType { recipe, stuff }

class MasterController extends GetxController {
  static MasterController instance = Get.put(MasterController());

  // Master Data Page
  final Rx<DataType> _dataType = Rx<DataType>(DataType.recipe);
  final Rx<List<StuffEntities>> _listStuff = Rx<List<StuffEntities>>([]);
  final Rx<List<StuffEntities>> _filteredListStuff = Rx<List<StuffEntities>>([]);
  final Rx<List<RecipeEntities>> _listRecipe = Rx<List<RecipeEntities>>([]);
  final Rx<List<RecipeEntities>> _filteredListRecipe = Rx<List<RecipeEntities>>([]);
  final Rx<bool> _isBtnEnabled = Rx<bool>(false);
  final Rx<List> _countryList = Rx<List>([]);

  // Add Stuff Page
  final Rx<StuffEntities> _stuff = Rx(const StuffEntities());

  // Add Recipe Page
  final Rx<RecipeEntities> _recipe = Rx(const RecipeEntities());
  final Rx<List<StuffOnRecipeEntities>> _listStuffOnEntities = Rx([]);
  final Rx<List> _listCountry = Rx([]);
  final Rx<bool> _loadingCountry = Rx(false);

  // Getter
  DataType get dataType => _dataType.value;
  List<StuffEntities> get listStuff => _listStuff.value;
  List<StuffEntities> get filteredListStuff => _filteredListStuff.value;
  List<RecipeEntities> get listRecipe => _listRecipe.value;
  List<RecipeEntities> get filteredListRecipe => _filteredListRecipe.value;
  bool get isBtnEnabled => _isBtnEnabled.value;
  StuffEntities get stuff => _stuff.value;
  RecipeEntities get recipe => _recipe.value;
  List get countryList => _countryList.value;
  List get listCountry => _listCountry.value;
  bool get loadingCountry => _loadingCountry.value;
  List<StuffOnRecipeEntities> get listStuffOnEntities => _listStuffOnEntities.value;

  TextEditingController stuffQtyController = TextEditingController();

  // ========================= Master Data Page ===============================
  @override
  void onInit() {
    getStuffList();
    getRecipeList();
    loadCountries();
    super.onInit();
  }

  void search(String value) {
    if (dataType == DataType.recipe) {
      _filteredListRecipe.value = listRecipe.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    } else {
      _filteredListStuff.value = listStuff.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }
  }

  Future<void> loadCountries() async {
    String content = await rootBundle.loadString('assets/data/parsed_countries.json');

    List<dynamic> countries = jsonDecode(content);
    _countryList.value = countries;
  }

  void changeDataType(index) {
    if (index == 0) {
      _dataType.value = DataType.recipe;
    } else {
      _dataType.value = DataType.stuff;
    }
  }

  void onAddPressed() {
    resetForm();
    if (dataType == DataType.recipe) {
      Get.toNamed('/master-data/recipe');
    } else {
      Get.toNamed('/master-data/stuff');
    }
  }

  Future<void> getStuffList() async {
    final sql = DatabaseHelper();
    final list = await sql.getStuff();
    _listStuff.value = list;
    _filteredListStuff.value = list;
  }

  Future<void> getRecipeList() async {
    final sql = DatabaseHelper();
    final list = await sql.getRecipe();
    _listRecipe.value = list;
    _filteredListRecipe.value = list;
  }

  // ========================= Add Stuff Page ===============================

  Future<void> onSave() async {
    final sql = DatabaseHelper();
    if (dataType == DataType.stuff) {
      await sql.saveStuff(stuff);
    } else {
      int id = await sql.saveRecipe(recipe);
      for (var e in listStuffOnEntities) {
        final newE = e.copyWith(idRecipe: id);
        await sql.saveStuffOnRecipe(newE);
      }
    }
    resetForm();
  }

  // ========================= Edit Stuff Page ===============================

  Future<void> editStuff(StuffEntities value) async {
    Get.toNamed('/master-data/stuff/edit');
    _stuff.value = value;
    _isBtnEnabled.value = isFilled();
  }

  Future<void> editRecipe(RecipeEntities value) async {
    Get.toNamed('/master-data/recipe/edit');
    _recipe.value = value;
    _loadingCountry.value = true;
    _listCountry.value = countryList.firstWhere((element) => element["name"] == recipe.continental)["countries"];
    await Future.delayed(const Duration(milliseconds: 500));
    _loadingCountry.value = false;
    final sql = DatabaseHelper();
    final stuffOnRecipeList = await sql.getStuffOnRecipe(value.id!);
    print(stuffOnRecipeList.length);
    _listStuffOnEntities.value = List.from([...stuffOnRecipeList]);
    _isBtnEnabled.value = isFilled();
  }

  Future<void> delete() async {
    final sql = DatabaseHelper();
    if (dataType == DataType.stuff) {
      await sql.deleteStuff(stuff.id!);
    } else {
      await sql.deleteRecipe(recipe.id!);
    }
    resetForm();
  }

  Future<void> onEdit() async {
    final sql = DatabaseHelper();
    if (dataType == DataType.stuff) {
      await sql.editStuff(stuff.id!, stuff);
    } else {
      await sql.editRecipe(recipe.id!, recipe);
    }
    resetForm();
  }

  // ========================= Common Edit Stuff ==============================

  Future<void> pickStuffImage() async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      Uint8List bytes = await file.readAsBytes();
      onChange('image', base64Encode(bytes));
    }
  }

  void onChange(String key, value) async {
    if (dataType == DataType.stuff) {
      switch (key) {
        case "image":
          _stuff.value = stuff.copyWith(image: value);
          break;

        case "name":
          _stuff.value = stuff.copyWith(name: value);
          break;

        case "stock":
          _stuff.value = stuff.copyWith(stock: int.tryParse(value) ?? 0);
          break;

        case "price":
          _stuff.value = stuff.copyWith(price: int.tryParse(value) ?? 0);
          break;

        case "description":
          _stuff.value = stuff.copyWith(description: value);
          break;

        case "unit":
          _stuff.value = stuff.copyWith(unit: value);
          break;

        default:
          break;
      }
    } else {
      switch (key) {
        case "image":
          _recipe.value = recipe.copyWith(image: value);
          break;

        case "name":
          _recipe.value = recipe.copyWith(name: value);
          break;

        case "continental":
          _loadingCountry.value = true;
          _recipe.value = recipe.copyWith(continental: value);
          _listCountry.value = countryList.firstWhere((element) => element["name"] == recipe.continental)["countries"];
          _recipe.value = recipe.nullCountries();
          await Future.delayed(const Duration(milliseconds: 500));
          _loadingCountry.value = false;
          break;

        case "countries":
          _recipe.value = recipe.copyWith(countries: value);
          break;

        case "duration":
          _recipe.value = recipe.copyWith(duration: int.tryParse(value) ?? 0);
          break;

        case "instruction":
          _recipe.value = recipe.copyWith(instruction: value);
          break;

        default:
          break;
      }
    }

    _isBtnEnabled.value = isFilled();
  }

  Future<void> onCancel() async {
    resetForm();
  }

  void deleteImage() {
    if (dataType == DataType.stuff) {
      _stuff.value = stuff.deleteImage();
    } else {
      _recipe.value = recipe.deleteImage();
    }
    _isBtnEnabled.value = isFilled();
  }

  void resetForm() {
    _stuff.value = const StuffEntities();
    _recipe.value = const RecipeEntities();
    _isBtnEnabled.value = false;
    _listStuffOnEntities.value = [];
    getRecipeList();
    getStuffList();
    Get.back();
  }

  bool isFilled() {
    if (dataType == DataType.stuff) {
      return (stuff.image != null && stuff.name != null && stuff.price != null && stuff.description != null);
    } else {
      return (recipe.image != null && recipe.name != null && recipe.continental != null && recipe.countries != null && recipe.duration != null && recipe.instruction != null);
    }
  }

  void addStuffOnRecipe(StuffEntities entities) {
    final stuffOnRecipe = StuffOnRecipeEntities(idRecipe: recipe.id, idStuff: entities.id, qty: int.tryParse(stuffQtyController.text) ?? 0);
    _listStuffOnEntities.value = List.from([...listStuffOnEntities, stuffOnRecipe]);
    Get.back();
  }

  void deleteStuffOnRecipe(int index) {
    listStuffOnEntities.removeAt(index);
    _listStuffOnEntities.value = List.from([...listStuffOnEntities]);
  }

  void deleteStuffOnRecipeEdit(int id, int index) async {
    final sql = DatabaseHelper();
    await sql.deleteStuffOnRecipe(id);
    deleteStuffOnRecipe(index);
  }

  void addStuffOnRecipeEdit(StuffEntities e) async {
    final stuffOnRecipe = StuffOnRecipeEntities(idRecipe: recipe.id, idStuff: e.id, qty: int.tryParse(stuffQtyController.text) ?? 0);
    final sql = DatabaseHelper();
    await sql.saveStuffOnRecipe(stuffOnRecipe);
    _listStuffOnEntities.value = List.from([...listStuffOnEntities, stuffOnRecipe]);
    Get.back();
  }
}
