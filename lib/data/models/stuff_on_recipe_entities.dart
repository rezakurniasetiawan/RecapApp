class StuffOnRecipeEntities {
  final int? id;
  final int? idRecipe;
  final int? idStuff;
  final int? qty;

  StuffOnRecipeEntities({this.id, this.idRecipe, this.idStuff, this.qty});

  StuffOnRecipeEntities copyWith({int? idRecipe, int? idStuff, int? qty}) {
    return StuffOnRecipeEntities(
      id: id,
      idRecipe: idRecipe ?? this.idRecipe,
      idStuff: idStuff ?? this.idStuff,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idRecipe': idRecipe,
      'idStuff': idStuff,
      'qty': qty,
    };
  }

  static StuffOnRecipeEntities fromJson(json) {
    return StuffOnRecipeEntities(
      id: json['id'],
      idRecipe: json['idRecipe'],
      idStuff: json['idStuff'],
      qty: json['qty'],
    );
  }
}
