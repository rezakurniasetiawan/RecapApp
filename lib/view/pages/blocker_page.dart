import 'package:flutter/material.dart';
import 'package:recipe/constant.dart';

class BlockerPage extends StatelessWidget {
  const BlockerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Masa Expired", style: CustomTextTheme.heading2),
          ],
        ),
      ),
    );
  }
}
