class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.moq,
    this.price,
    this.discountedPrice,
  });

  final String? id;
  final String? name;
  final String? moq;
  final String? price;
  final String? discountedPrice;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      moq: json["moq"],
      price: json["price"],
      discountedPrice: json["discounted_price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "moq": moq,
        "price": price,
        "discounted_price": discountedPrice,
      };
}
