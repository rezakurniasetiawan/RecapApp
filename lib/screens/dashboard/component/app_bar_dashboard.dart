import 'package:flutter/material.dart';

import '../../../utils/theme_utils .dart';

class AppBarDashboard extends StatelessWidget {
  const AppBarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            'Best Food For Your Taste',
            style: TextStyle(
                color: ThemeUtils.ColorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: ThemeUtils.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(
            Icons.favorite_border,
            color: ThemeUtils.primaryColor,
          ),
        )
      ],
    );
  }
}
