import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:recipe/controller/home_controller.dart';

class CountryListPage extends StatelessWidget {
  CountryListPage({super.key});
  final HomeController _c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Country List",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              onChanged: (value) => _c.searchCountries(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                label: Text("Find Country"),
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 30),
                children: [
                  ..._c.filterCountryList.map(
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
