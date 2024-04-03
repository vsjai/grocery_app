class UserModel {
  UserModel({
    this.userToken,
    this.id,
    this.name,
    this.mobile,
    this.email,
  });

  final String? userToken;
  final int? id;
  final String? name;
  final String? mobile;
  final String? email;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userToken: json["user_token"],
      id: int.tryParse(json["id"].toString()),
      name: json["name"],
      mobile: json["mobile"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_token": userToken,
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
      };
}
