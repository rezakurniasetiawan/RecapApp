import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme_utils%20.dart';

class MenuMasterData extends StatefulWidget {
  const MenuMasterData({super.key});

  @override
  State<MenuMasterData> createState() => _MenuMasterDataState();
}

class _MenuMasterDataState extends State<MenuMasterData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ItemMenu(
                title: 'Country',
                press: () {
                  Navigator.pushNamed(context, '/country');
                }),
            const SizedBox(
              height: 10,
            ),
            ItemMenu(title: 'Food', press: () {
                  Navigator.pushNamed(context, '/food');

            })
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({super.key, required this.title, required this.press});

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ThemeUtils.primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: ThemeUtils.ColorWhite,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
