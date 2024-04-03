import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/provider/grocery_provider.dart';
import 'package:grocery_app/screens/add_update_screen.dart';
import 'package:grocery_app/screens/product_page.dart';
import 'package:provider/provider.dart';

class GroceryItem extends StatelessWidget {
  final String imagePath;

  final ProductModel model;

  const GroceryItem({
    super.key,
    required this.model,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final gp = Provider.of<GroceryProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      model: model,
                      imagePath: imagePath,
                    ),
                  ));
            },
            child: SizedBox(
              height: 100,
              child: Image.asset(imagePath),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.name ?? "",
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddUpdateScreen(
                                      title: "Update",
                                      model: model,
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              gp.deleteProduct(model.id ?? "", context);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${model.discountedPrice}",
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${model.price}",
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white),
                          onPressed: () {},
                          child: const Icon(Icons.favorite_border)),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.green),
                          onPressed: () {},
                          child: const Icon(Icons.shopping_cart)),
                    ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
