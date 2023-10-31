import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/controller/recipe_controller.dart';
import 'package:recipe/data/models/recipe_entities.dart';
import 'package:recipe/data/models/stuff_entities.dart';

class RecipePage extends StatelessWidget {
  RecipePage({super.key});
  final RecipeEntities args = Get.arguments;
  final RecipeController _c = Get.put(RecipeController());

  final formatCurrency = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.memory(
              base64Decode(args.image!),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(args.name!, style: CustomTextTheme.heading2),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${args.duration} Min",
                    style: CustomTextTheme.heading5.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                Text("Ingredients", style: CustomTextTheme.heading4),
                if (_c.stuffOnRecipe.isNotEmpty) const SizedBox(height: 15),
                if (_c.stuffOnRecipe.isNotEmpty)
                  Container(
                    color: cardColor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._c.stuffOnRecipe
                            .asMap()
                            .map((index, e) {
                              StuffEntities? entities = _c.stuff.where((el) => el.id == e.idStuff).firstOrNull;
                              return MapEntry(
                                index,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${index + 1}. ${entities?.name ?? '-'} ${e.qty} ${entities?.unit ?? '-'} @ ${formatCurrency.format(entities!.price!)}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        formatCurrency.format(entities.price! * e.qty!),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                            .values
                            .toList(),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total", style: CustomTextTheme.heading4),
                              Text(formatCurrency.format(_c.total), style: CustomTextTheme.heading4),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 15),
                Text("Instruction", style: CustomTextTheme.heading4),
                const SizedBox(height: 15),
                Text("${args.instruction}")
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
