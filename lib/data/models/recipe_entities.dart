class RecipeEntities {
  final int? id;
  final String? name;
  final String? image;
  final String? countries;
  final int? duration;
  final String? instruction;

  const RecipeEntities({this.id, this.name, this.image, this.countries, this.duration, this.instruction});

  RecipeEntities copyWith({String? image, String? name, String? countries, int? duration, String? instruction}) {
    return RecipeEntities(
      id: id,
      name: name ?? this.name,
      image: image ?? this.image,
      countries: countries ?? this.countries,
      duration: duration ?? this.duration,
      instruction: instruction ?? this.instruction,
    );
  }

  RecipeEntities deleteImage({String? image, String? name, String? countries, int? duration, String? instruction}) {
    return RecipeEntities(
      id: id,
      image: null,
      name: name ?? this.name,
      countries: countries ?? this.countries,
      duration: duration ?? this.duration,
      instruction: instruction ?? this.instruction,
    );
  }

  Map<String, dynamic> toMap() => {
        'image': image,
        'name': name,
        'countries': countries,
        'duration': duration,
        'instruction': instruction,
      };

  static RecipeEntities fromJson(json) => RecipeEntities(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        countries: json['countries'],
        duration: json['duration'],
        instruction: json['instruction'],
      );
}
