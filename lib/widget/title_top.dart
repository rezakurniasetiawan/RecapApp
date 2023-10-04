import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme_utils%20.dart';

class TitleTop extends StatelessWidget {
  const TitleTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Country Food',
                style: TextStyle(
                    color: ThemeUtils.ColorBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ThemeUtils.primaryColor),
              )
            ],
          ),
          Text(
            'View More',
            style: TextStyle(
                color: ThemeUtils.primaryColor,
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
