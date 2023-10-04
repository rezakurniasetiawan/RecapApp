import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/utils/theme_utils%20.dart';

class BannerDashboard extends StatelessWidget {
  const BannerDashboard({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ThemeUtils.primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    'Food Recipe Master Data',
                    style: TextStyle(
                        height: 1.3,
                        color: ThemeUtils.ColorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: press,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ThemeUtils.ColorWhite),
                    child: Center(
                      child: Text(
                        'More',
                        style: TextStyle(
                            height: 1.3,
                            color: ThemeUtils.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: SvgPicture.asset('assets/svg/banner-recipe.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
