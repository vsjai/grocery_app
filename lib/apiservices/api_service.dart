import 'dart:convert';

import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>?> getProductList() async {
    var res = await http.post(
        Uri.parse('https://shareittofriends.com/demo/flutter/productList.php'),
        body: {'user_login_token': 'c2a2f674c6f6a1d2374da1ebfab69adc'},
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode == 200) {
      var tempList = (json.decode(res.body) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return tempList;
    } else {
      return null;
    }
  }

  Future<bool> addProduct(
      {required String name,
      required String moq,
      required String price,
      required String discountedPrice}) async {
    var res = await http.post(
        Uri.parse('https://shareittofriends.com/demo/flutter/addProduct.php'),
        body: {
          'user_login_token': 'c2a2f674c6f6a1d2374da1ebfab69adc',
          'name': name,
          'moq': moq,
          'price': price,
          'discounted_price': discountedPrice
        },
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(
      {required String name,
      required String moq,
      required String price,
      required String discountedPrice,
      required String id}) async {
    try {
      var res = await http.post(
          Uri.parse(
              'https://shareittofriends.com/demo/flutter/editProduct.php'),
          body: {
            "id": id,
            'user_login_token': 'c2a2f674c6f6a1d2374da1ebfab69adc',
            'name': name,
            'moq': moq,
            'price': price,
            'discounted_price': discountedPrice
          },
          encoding: Encoding.getByName("utf-8"));

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      var res = await http.post(
          Uri.parse(
              'https://shareittofriends.com/demo/flutter/deleteProduct.php'),
          body: {
            'user_login_token': 'c2a2f674c6f6a1d2374da1ebfab69adc',
            'id': id
          },
          encoding: Encoding.getByName("utf-8"));

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> login(
      {required String password, required String email}) async {
    try {
      var res = await http.post(
          Uri.parse('https://shareittofriends.com/demo/flutter/Login.php'),
          body: {'email': email, 'password': password});
      var user = json.decode(res.body);
      UserModel myUser = UserModel.fromJson(user['data']);
      return myUser;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> register(
      {required String name,
      required String email,
      required String mobileNumber,
      required String password}) async {
    try {
      var res = await http.post(
          Uri.parse('https://shareittofriends.com/demo/flutter/Register.php'),
          body: {
            'name': name,
            'email': email,
            'mobile': mobileNumber,
            'password': password
          });
      var user = json.decode(res.body);
      UserModel myUser = UserModel.fromJson(user['data']);
      return myUser;
    } catch (e) {
      return null;
    }
  }
}
