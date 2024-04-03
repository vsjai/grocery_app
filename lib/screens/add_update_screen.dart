import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/provider/grocery_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_button.dart';

class AddUpdateScreen extends StatefulWidget {
  final String title;
  final ProductModel? model;
  const AddUpdateScreen({required this.title, this.model, super.key});

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  @override
  void initState() {
    if (widget.model != null) {
      nameController.text = widget.model?.name ?? "";
      moqController.text = widget.model?.moq ?? "";
      priceController.text = widget.model?.price ?? "";
      discountedPriceController.text = widget.model?.discountedPrice ?? "";
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController moqController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountedPriceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final gp = Provider.of<GroceryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Title(color: Colors.black, child: Text("${widget.title} Product")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: moqController,
                decoration: const InputDecoration(labelText: 'MOQ'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the MOQ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: discountedPriceController,
                decoration:
                    const InputDecoration(labelText: 'Discounted Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the discounted price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: "Submit",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ProductModel product = ProductModel(
                      name: nameController.text,
                      moq: moqController.text,
                      price: priceController.text,
                      discountedPrice: discountedPriceController.text,
                    );
                    if (widget.model != null) {
                      await gp.updateProduct(
                          product, widget.model?.id ?? "", context);
                    } else {
                      await gp.addProduct(product, context);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
