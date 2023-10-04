import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key, required this.countryNames});

  final List<String> countryNames;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
       shrinkWrap: true,
      itemCount: countryNames.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(countryNames[index]),
        );
      },
    );
  }
}
