import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/controller/home_controller.dart';
import 'package:recipe/view/widget/banner_card_home_widger.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController _c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 30),
            const Spacer(),
            const Text(
              "Recipe",
              style: TextStyle(color: textColor),
            ),
            const SizedBox(width: 2),
            Text(
              "App",
              style: CustomTextTheme.heading6.copyWith(color: mutedColor),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Obx(
        () => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (value) => _c.search(value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(FeatherIcons.search),
                  filled: true,
                  hintStyle: CustomTextTheme.heading5,
                  fillColor: cardColor,
                  hintText: "Cari",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const BannerCardHomeWidget(),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _c.changeType(TypeDashboard.countries),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                        color: _c.type == TypeDashboard.countries ? primaryColor : cardColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Icon(FeatherIcons.flag, color: _c.type == TypeDashboard.countries ? Colors.white : mutedColor),
                          const SizedBox(width: 10),
                          Text("Berdasarkan Benua", style: CustomTextTheme.heading5.copyWith(color: _c.type == TypeDashboard.countries ? Colors.white : mutedColor)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => _c.changeType(TypeDashboard.food),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                        color: _c.type == TypeDashboard.food ? primaryColor : cardColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Icon(FeatherIcons.smile, color: _c.type == TypeDashboard.food ? Colors.white : mutedColor),
                          const SizedBox(width: 10),
                          Text("Berdasarkan Menu", style: CustomTextTheme.heading5.copyWith(color: _c.type == TypeDashboard.food ? Colors.white : mutedColor)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            (_c.type == TypeDashboard.countries)
                ? _c.loading == Status.loading
                    ? const Expanded(child: Center(child: CircularProgressIndicator()))
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lihat Resep Berdasarkan Benua", style: CustomTextTheme.heading4),
                            const SizedBox(height: 15),
                            GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 3.5,
                              shrinkWrap: true,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ...(_c.filterCountryList).map((e) {
                                  return Container(
                                    padding: const EdgeInsets.all(15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: InkWell(
                                      onTap: () => Get.toNamed('/recipe-country', arguments: e),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: primaryColor.withOpacity(0.2),
                                            ),
                                            child: const Center(
                                              child: Icon(Icons.public, color: primaryColor, size: 30),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            e['name'],
                                            style: CustomTextTheme.heading5,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Lihat resep di ${e['name']}",
                                            style: CustomTextTheme.heading6.copyWith(color: mutedColor),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              ],
                            )
                          ],
                        ),
                      )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lihat Berdasarkan Menu", style: CustomTextTheme.heading4),
                        const SizedBox(height: 15),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                          children: [
                            ...(_c.filteredListRecipe.length > 4 ? _c.filteredListRecipe.sublist(0, 4) : _c.filteredListRecipe).map((e) {
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
                        )
                      ],
                    ),
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => Get.toNamed('/master-data'),
        child: const Icon(
          Icons.food_bank_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
