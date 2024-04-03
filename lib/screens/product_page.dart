import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/provider/grocery_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final ProductModel model;
  final String imagePath;
  const ProductPage({required this.model, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/img1.png",
      "assets/images/img2.png",
      "assets/images/img3.png",
    ];
    final gp = Provider.of<GroceryProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Image.asset(
                    images[index],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    gp.updateSelectedIndex(index);
                  },
                ),
              ),
              Positioned(
                  top: 30,
                  left: 15,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  )),
              Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width / 2.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.map((url) {
                    int index = images.indexOf(url);
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == gp.selectedIndex
                            ? Colors.black
                            : Colors.black12,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.price ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const Text("₹/piece", style: TextStyle(fontSize: 20)),
                  ],
                ),
                const Text(
                  "~150 gr/piece",
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Lettuce is an annual plant of the daisy family, Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. Lettuce is most often used for salads, although it is also seen in other kinds of food, such as soups, sandwiches and wraps; it can also be grilled.',
                  style: TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
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
                      flex: 3,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          // Add to cart functionality
                        },
                        label: const Text('ADD TO CART'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
