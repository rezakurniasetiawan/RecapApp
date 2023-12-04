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
                  margin: EdgeInsets.only(top: 30),
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
                        "Resep Seluruh Dunia",
                        style: CustomTextTheme.heading3.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cari resep yang cocok di seluruh dunia",
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
            top: 0,
            child: Image.asset(
              'assets/images/chef.png',
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
