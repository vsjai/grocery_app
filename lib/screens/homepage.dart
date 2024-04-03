import 'package:flutter/material.dart';
import 'package:grocery_app/apiservices/data_store.dart';
import 'package:grocery_app/provider/grocery_provider.dart';
import 'package:grocery_app/screens/add_update_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'widgets/grocery_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final gp = Provider.of<GroceryProvider>(context, listen: false);
    gp.getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gp = Provider.of<GroceryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vegetables ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUpdateScreen(
                        title: "Add",
                      ),
                    ));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                DataSource().deleteUser().then((value) => {
                      if (value == true)
                        {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ))
                        }
                    });
              },
              icon: const Icon(
                Icons.exit_to_app_outlined,
                color: Colors.black,
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => gp.getProductList(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    gp.getShowingList(value);
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40,
                  child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: gp.vegetablesList.map((e) {
                        if (e == gp.selectedType) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 226, 203, 252),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Color.fromARGB(255, 117, 28, 230),
                                ),
                                Text(
                                  e,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 117, 28, 230),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return GestureDetector(
                              onTap: () => gp.updateSelecteType(e),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Text(e)));
                        }
                      }).toList()),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: gp.filteredProducts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int imageIndex = index % 3 + 1;
                    return GroceryItem(
                      model: gp.filteredProducts[index],
                      imagePath: "assets/images/img$imageIndex.png",
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
