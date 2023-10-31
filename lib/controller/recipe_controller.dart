import 'package:get/get.dart';
import 'package:recipe/data/database_helper.dart';
import 'package:recipe/data/models/recipe_entities.dart';
import 'package:recipe/data/models/stuff_entities.dart';
import 'package:recipe/data/models/stuff_on_recipe_entities.dart';

class RecipeController extends GetxController {
  static RecipeController instance = Get.put(RecipeController());
  final Rx<List<StuffOnRecipeEntities>> _stuffOnRecipe = Rx<List<StuffOnRecipeEntities>>([]);
  final Rx<List<StuffEntities>> _stuff = Rx<List<StuffEntities>>([]);
  final Rx<int> _total = Rx<int>(0);

  List<StuffOnRecipeEntities> get stuffOnRecipe => _stuffOnRecipe.value;
  List<StuffEntities> get stuff => _stuff.value;
  int get total => _total.value;

  @override
  void onInit() {
    Future.microtask(() async {
      await getData();
      await getTotal();
    });
    super.onInit();
  }

  Future<void> getData() async {
    final sql = DatabaseHelper();
    final RecipeEntities args = Get.arguments;
    final dataStuffOnRecipe = await sql.getStuffOnRecipe(args.id!);
    final dataStuff = await sql.getStuff();

    _stuff.value = dataStuff;
    _stuffOnRecipe.value = dataStuffOnRecipe;

    getTotal();
  }

  Future<void> getTotal() async {
    int tempTotal = 0;

    print(stuffOnRecipe.length);

    for (var e in stuffOnRecipe) {
      StuffEntities? data = stuff.where((element) => element.id == e.idStuff).firstOrNull;
      tempTotal += (data?.price ?? 0) * e.qty!;
    }

    _total.value = tempTotal;
  }
}
