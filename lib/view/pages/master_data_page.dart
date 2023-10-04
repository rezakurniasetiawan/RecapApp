import 'package:flutter/material.dart';

class MasterDataPage extends StatelessWidget {
  const MasterDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Data",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              onTap: (value) {},
              tabs: const [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Recipe'),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Stuff'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          onChanged: (value) => {},
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            label: Text("Find Country"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
