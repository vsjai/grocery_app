import 'package:flutter/material.dart';
import 'package:grocery_app/apiservices/api_service.dart';
import 'package:grocery_app/models/product_model.dart';

class GroceryProvider extends ChangeNotifier {
  var vegetablesList = [
    "Cabbage & lettuce (14)",
    "Cuccumber & Tomatos (5)",
    "Onions & Garlic (8)",
    "Peppers (7)",
    "Potatos & Cauliflower (9)"
  ];

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  List<ProductModel> get filteredProducts => _filteredProducts;
  List<ProductModel> _filteredProducts = [];

  String _selectedType = "Cabbage & lettuce (14)";
  String get selectedType => _selectedType;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelecteType(String value) {
    _selectedType = value;
    notifyListeners();
  }

  String? _query;
  String get query => _query ?? "";

  getShowingList(String query) {
    if (query.isEmpty) {
      _filteredProducts = productList;
    } else {
      _filteredProducts = productList
          .where((product) =>
              (product.name ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  updateList(List<ProductModel> list) {
    _productList = list;
    _filteredProducts = list;
    notifyListeners();
  }

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  getProductList() async {
    var list = await ApiService().getProductList();
    if (list != null) {
      updateList(list);
    }
  }

  Future<void> addProduct(ProductModel product, BuildContext context) async {
    final res = await ApiService().addProduct(
        name: product.name ?? "",
        moq: product.moq ?? "",
        price: product.price ?? "",
        discountedPrice: product.discountedPrice ?? "");
    if (res && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Add Successfully")));
    }
  }

  Future<void> updateProduct(
      ProductModel product, String id, BuildContext context) async {
    final res = await ApiService().updateProduct(
        name: product.name ?? "",
        moq: product.moq ?? "",
        price: product.price ?? "",
        discountedPrice: product.discountedPrice ?? "",
        id: id);
    if (res && context.mounted) {
      getProductList();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Updated Successfully")));
    }
  }

  Future<void> deleteProduct(String id, BuildContext context) async {
    final res = await ApiService().deleteProduct(id);
    if (res && context.mounted) {
      removeProductFromList(id);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Updated Successfully")));
    }
  }

  removeProductFromList(String id) {
    _filteredProducts.removeWhere((element) => element.id == id);
    _productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
