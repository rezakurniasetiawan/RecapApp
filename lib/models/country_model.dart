class CountryModel {
  final String uuId;
  String countryName;

  CountryModel({
    required this.uuId,
    required this.countryName,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      uuId: json['uuId'],
      countryName: json['country_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuId': uuId,
      'country_name': countryName,
    };
  }
}
