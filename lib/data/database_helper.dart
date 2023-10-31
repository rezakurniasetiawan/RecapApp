import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/data/models/recipe_entities.dart';
import 'package:recipe/data/models/stuff_entities.dart';
import 'package:recipe/data/models/stuff_on_recipe_entities.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Stuff(id INTEGER PRIMARY KEY, image TEXT, name TEXT, price INT, stock INT, unit TEXT, description TEXT)");
    await db.execute("CREATE TABLE Recipe(id INTEGER PRIMARY KEY, image TEXT, name TEXT, duration INT, countries TEXT, instruction TEXT)");
    await db.execute("CREATE TABLE StuffOnRecipe(id INTEGER PRIMARY KEY, idRecipe INTEGER, idStuff INTEGER, qty INTEGER)");
    print("Table is created");
  }

//insertion
  Future<int> saveStuff(StuffEntities stuff) async {
    var dbClient = await db;
    int res = await dbClient.insert("Stuff", stuff.toMap());
    return res;
  }

  Future<int> saveRecipe(RecipeEntities recipe) async {
    var dbClient = await db;
    int res = await dbClient.insert("Recipe", recipe.toMap());
    return res;
  }

  //deletion
  Future<int> deleteStuff(int id) async {
    var dbClient = await db;
    int res = await dbClient.delete("Stuff", where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteRecipe(int id) async {
    var dbClient = await db;
    int res = await dbClient.delete("Recipe", where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //deletion
  Future<int> editStuff(int id, StuffEntities stuff) async {
    var dbClient = await db;
    int res = await dbClient.update("Stuff", stuff.toMap(), where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> editRecipe(int id, RecipeEntities recipe) async {
    var dbClient = await db;
    int res = await dbClient.update("Recipe", recipe.toMap(), where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<StuffEntities>> getStuff() async {
    var dbClient = await db;
    final res = await dbClient.query('Stuff');
    return res.map((e) => StuffEntities.fromJson(e)).toList();
  }

  Future<List<RecipeEntities>> getRecipe() async {
    var dbClient = await db;
    final res = await dbClient.query('Recipe');
    return res.map((e) => RecipeEntities.fromJson(e)).toList();
  }

  Future<int> saveStuffOnRecipe(StuffOnRecipeEntities stuffOnRecipe) async {
    var dbClient = await db;
    int res = await dbClient.insert("StuffOnRecipe", stuffOnRecipe.toMap());
    return res;
  }

  Future<List<StuffOnRecipeEntities>> getStuffOnRecipe(int idRecipe) async {
    var dbClient = await db;
    final res = await dbClient.query('StuffOnRecipe', where: 'idRecipe = ?', whereArgs: [idRecipe]);
    return res.map((e) => StuffOnRecipeEntities.fromJson(e)).toList();
  }

  Future<int> deleteStuffOnRecipe(int id) async {
    var dbClient = await db;
    final res = await dbClient.delete('StuffOnRecipe', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<RecipeEntities>> getRecipeOnCountry(String code) async {
    var dbClient = await db;
    final res = await dbClient.query('Recipe', where: 'countries = ?', whereArgs: [code]);
    return res.map((e) => RecipeEntities.fromJson(e)).toList();
  }
}
