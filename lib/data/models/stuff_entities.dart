import 'package:equatable/equatable.dart';

class StuffEntities extends Equatable {
  final int? id;
  final String? image;
  final String? name;
  // final int? stock;
  final int? price;
  final String? description;
  final String? unit;

  const StuffEntities({this.id, this.image, this.name, this.price, this.description, this.unit});

  StuffEntities copyWith({String? image, String? name, int? stock, int? price, String? description, String? unit}) {
    return StuffEntities(
      id: id,
      image: image ?? this.image,
      name: name ?? this.name,
      // stock: stock ?? this.stock,
      price: price ?? this.price,
      description: description ?? this.description,
      unit: unit ?? this.unit,
    );
  }

  StuffEntities deleteImage({String? image, String? name, int? stock, int? price, String? description, String? unit}) {
    return StuffEntities(
      id: id,
      image: null,
      name: name ?? this.name,
      // stock: stock ?? this.stock,
      price: price ?? this.price,
      description: description ?? this.description,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() => {
        'image': image,
        'name': name,
        // 'stock': stock,
        'price': price,
        'description': description,
        'unit': unit,
      };

  static StuffEntities fromJson(json) => StuffEntities(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        // stock: json['stock'],
        price: json['price'],
        description: json['description'],
        unit: json['unit'],
      );

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        // stock,
        price,
        description,
        unit,
      ];
}
