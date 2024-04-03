import 'dart:convert';

import 'package:grocery_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSource {
  addShareData(Map<String, dynamic> map) async {
    var instance = await SharedPreferences.getInstance();
    instance.setString("user", jsonEncode(map));
  }

  Future<UserModel?> getUser() async {
    var instance = await SharedPreferences.getInstance();
    var res = instance.getString("user");
    if (res != null) {
      var json = jsonDecode(res);
      var user = UserModel.fromJson(json);
      return user;
    }
    return null;
  }

  Future<bool?> deleteUser() async {
    var instance = await SharedPreferences.getInstance();
    return await instance.clear();
  }
}
