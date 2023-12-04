import 'package:get/get.dart';
import 'package:recipe/data/database_helper.dart';
import 'package:recipe/data/models/recipe_entities.dart';

class RecipeOnCountryController extends GetxController {
  static RecipeOnCountryController instance = Get.find();
  final Rx<List<RecipeEntities>> _recipe = Rx<List<RecipeEntities>>([]);

  List<RecipeEntities> get recipe => _recipe.value;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    final sql = DatabaseHelper();
    final Map<String, dynamic> args = Get.arguments;
    final result = await sql.getRecipeOnCountry(args['name']);
    _recipe.value = result;
  }
}
