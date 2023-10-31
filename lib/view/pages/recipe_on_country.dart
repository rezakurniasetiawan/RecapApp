import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/controller/recipe_on_country_controller.dart';

class RecipeOnCountry extends StatelessWidget {
  RecipeOnCountry({super.key});
  final Map<String, dynamic> args = Get.arguments;
  final RecipeOnCountryController _c = Get.put(RecipeOnCountryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Recipe on ${args['country']}",
          style: const TextStyle(color: textColor),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(15),
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 4,
              children: [
                ...(_c.recipe).map((e) {
                  return InkWell(
                    onTap: () => Get.toNamed('/recipe', arguments: e),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      base64Decode(e.image ?? ''),
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                    child: Text(
                                      "${e.countries?.toUpperCase()}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextTheme.heading5.copyWith(color: cardColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(e.name ?? '', style: CustomTextTheme.heading4),
                            Text(
                              e.instruction ?? '',
                              style: CustomTextTheme.heading5.copyWith(color: mutedColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
