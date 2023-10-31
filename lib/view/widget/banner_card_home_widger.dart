import 'package:flutter/material.dart';
import 'package:recipe/constant.dart';

class BannerCardHomeWidget extends StatelessWidget {
  const BannerCardHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Worldwide Recipe",
                        style: CustomTextTheme.heading3.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Find all suitable recipe all around the world",
                        style: CustomTextTheme.heading5.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
              )
            ],
          ),
          Positioned(
            right: 0,
            top: -10,
            child: Image.asset(
              'assets/images/burger.png',
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
