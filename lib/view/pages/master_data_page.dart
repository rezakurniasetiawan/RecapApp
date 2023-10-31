import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/controller/master_controller.dart';

class MasterDataPage extends StatelessWidget {
  MasterDataPage({super.key});
  final MasterController _c = Get.put(MasterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                onChanged: (value) => _c.search(value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(FeatherIcons.search),
                  filled: true,
                  hintStyle: CustomTextTheme.heading5,
                  fillColor: backgroundColor,
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: backgroundColor,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: primaryColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (value) => _c.changeDataType(value),
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Recipe', style: CustomTextTheme.heading5.copyWith(color: textColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Stuff', style: CustomTextTheme.heading5.copyWith(color: textColor)),
                        ),
                      ],
                    ),
                    const Divider(height: 0),
                    Expanded(
                      child: Container(
                        color: backgroundColor,
                        child: TabBarView(
                          children: [
                            Obx(
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
                                      ..._c.filteredListRecipe.map((e) {
                                        return InkWell(
                                          onTap: () => _c.editRecipe(e),
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
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Obx(
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
                                      ..._c.filteredListStuff.map((e) {
                                        return InkWell(
                                          onTap: () => _c.editStuff(e),
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
                                                          width: 75,
                                                          decoration: BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                          child: Text(
                                                            "${e.stock} ${e.unit}",
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
                                                    e.description ?? '',
                                                    style: CustomTextTheme.heading5.copyWith(color: mutedColor),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () => _c.onAddPressed(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
