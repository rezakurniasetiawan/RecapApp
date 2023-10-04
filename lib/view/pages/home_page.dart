import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "MyRecipe",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_outline),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            const BannerCardHomeWidget(),
            _c.loading == Status.loading
                ? const Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Country List",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                onPressed: () {
                                  _c.loadCountries();
                                  Get.toNamed('/country-list');
                                },
                                child: const Text("View All"),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.only(bottom: 30),
                            children: [
                              ..._c.countryList.sublist(0, 10).map(
                                    (e) => ListTile(
                                      onTap: () {},
                                      leading: SvgPicture.network(e['flag'], width: 50),
                                      title: Text(e['country']),
                                      subtitle: Text(
                                        "Find food recipe in ${e['country']}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
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
