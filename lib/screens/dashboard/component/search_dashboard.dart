import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme_utils%20.dart';

class SearchDashboard extends StatelessWidget {
  const SearchDashboard({super.key, required this.onSearchTextChanged});
  final void Function(String) onSearchTextChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ThemeUtils.primaryColor.withOpacity(0.15)),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.search,
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  onSearchTextChanged(value);
                },
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'Search country food',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
